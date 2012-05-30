require 'net/http'
require 'uri'
require 'tmpdir'

module Vatsim
  # Stores parsed data from vatsim data format
  class Data

    attr_reader :pilots, :atc, :prefiles, :general, :servers, :voice_servers

    STATUS_URL = "http://status.vatsim.net/status.txt"
    STATUS_DOWNLOAD_INTERVAL = 60*60*6 # 6 hours
    DATA_DOWNLOAD_INTERVAL = 60*2 # 2 minutes
    STATUS_FILE_PATH = Dir::tmpdir + "/vatsim-status.txt"
    DATA_FILE_PATH = Dir::tmpdir + "/vatsim-data.txt"

    def initialize
      @pilots = Array.new
      @atc = Array.new
      @prefiles = Array.new
      @servers = Array.new
      @voice_servers = Array.new
      @general = Hash.new

      parse
    end

    private

    # Parse the vatsim data file and store output as necessary
    def parse
      download_files

      parsing_clients = false
      parsing_prefile = false
      parsing_general = false
      parsing_servers = false
      parsing_voice_servers = false

      File.open(DATA_FILE_PATH, 'r:ascii-8bit').each { |line|

        if line.start_with? ";"
          parsing_clients = false
          parsing_prefile = false
          parsing_general = false
          parsing_servers = false
          parsing_voice_servers = false
        elsif parsing_clients
          clienttype = line.split(":")[3]
          if clienttype.eql? "PILOT"
            @pilots << Pilot.new(line)
          elsif clienttype.eql? "ATC"
            @atc << ATC.new(line)
          end
        elsif parsing_prefile
          @prefiles << Prefile.new(line)
        elsif parsing_general
          line_split = line.split("=")
          @general[line_split[0].strip.downcase.gsub(" ", "_")] = line_split[1].strip
        elsif parsing_servers
          @servers << Server.new(line)
        elsif parsing_voice_servers
          @voice_servers << VoiceServer.new(line) if line.length > 2 # ignore last, empty line for voice server that contains 2 characters
        end

        parsing_clients = true if line.start_with? "!CLIENTS:"
        parsing_prefile = true if line.start_with? "!PREFILE:"
        parsing_general = true if line.start_with? "!GENERAL:"
        parsing_servers = true if line.start_with? "!SERVERS:"
        parsing_voice_servers = true if line.start_with? "!VOICE SERVERS:"
      }
    end

    # Initialize the system by downloading status and vatsim data files
    def download_files
      if !File.exists?(STATUS_FILE_PATH) or File.mtime(STATUS_FILE_PATH) < Time.now - STATUS_DOWNLOAD_INTERVAL
       download_to_file STATUS_URL, STATUS_FILE_PATH
      end

      if !File.exists?(DATA_FILE_PATH) or File.mtime(DATA_FILE_PATH) < Time.now - DATA_DOWNLOAD_INTERVAL
        download_to_file random_data_url, DATA_FILE_PATH
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
      file = File.open(STATUS_FILE_PATH)
      file.each {|line|
        if line.start_with? "url0"
          url0s << line.split("=").last
        end
      }
      return url0s[rand(url0s.length)]
     end
  end
end

