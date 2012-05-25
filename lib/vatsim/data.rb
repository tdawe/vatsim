require 'net/http'
require 'uri'
require 'tmpdir'

module Vatsim
  # Stores parsed data from vatsim data format
  class Data

    attr_reader :clients, :pilots, :atc, :prefiles, :general

    STATUS_URL = "http://status.vatsim.net/status.txt"
    STATUS_DOWNLOAD_INTERVAL = 60*60*6 # 6 hours
    DATA_DOWNLOAD_INTERVAL = 60*2 # 2 minutes

    def initialize properties = nil
      @clients = Array.new
      @pilots = Array.new
      @atc = Array.new
      @prefiles = Array.new
      @general = Hash.new

      @status_file_path = Dir::tmpdir + "/vatsim-status.txt"
      @data_file_path = Dir::tmpdir + "/vatsim-data.txt"
      @refresh_files = true

      if !properties.nil?
        @status_file_path = properties["status_file_path"] if properties.has_key?("status_file_path")
        @data_file_path = properties["data_file_path"] if properties.has_key?("data_file_path")
        @refresh_files = properties["download_files"] if properties.has_key?("download_files")
      end

      parse
    end

    private

    # Parse the vatsim data file and store output as necessary
    def parse
      download_files if @refresh_files

      parsing_clients = false
      parsing_prefile = false
      parsing_general = false

      File.open(@data_file_path, 'r:ascii-8bit').each { |line|

        parsing_clients = false if line.start_with? ";"
        parsing_prefile = false if line.start_with? ";"
        parsing_general = false if line.start_with? ";"

        if parsing_clients
          clienttype = line.split(":")[3]
          if clienttype.eql? "PILOT"
            pilot = Pilot.new(line)
            @clients << pilot
            @pilots << pilot
          elsif clienttype.eql? "ATC"
            controller = ATC.new(line)
            @clients << controller
            @atc << controller
          end
        elsif parsing_prefile
          @prefiles << Prefile.new(line)
        elsif parsing_general
          line_split = line.split("=")
          @general[line_split[0].strip.downcase.gsub(" ", "_")] = line_split[1].strip
        end

        parsing_clients = true if line.start_with? "!CLIENTS:"
        parsing_prefile = true if line.start_with? "!PREFILE:"
        parsing_general = true if line.start_with? "!GENERAL:"
      }
    end

    # Initialize the system by downloading status and vatsim data files
    def download_files
      if !File.exists?(@status_file_path) or File.mtime(@status_file_path) < Time.now - STATUS_DOWNLOAD_INTERVAL
       download_to_file STATUS_URL, @status_file_path
      end

      if !File.exists?(@data_file_path ) or File.mtime(@data_file_path ) < Time.now - DATA_DOWNLOAD_INTERVAL
        download_to_file random_data_url, @data_file_path
      end
    end

    # Download a url to a file path
    def download_to_file url, file
      url = URI.parse(URI.encode(url.strip))

      File.new(file, File::CREAT)

      Net::HTTP.start(url.host) { |http|
        resp = http.get(url.path)
        open(file, "wb") { |file|
          file.write(resp.body)
        }
      }
    end

    # Return random vatsim data url from status file
    def random_data_url
      url0s = Array.new
      file = File.open(@status_file_path)
      file.each {|line|
        if line.start_with? "url0"
          url0s << line.split("=").last
        end
      }
      return url0s[rand(url0s.length)]
     end
  end
end

