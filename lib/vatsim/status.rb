require 'net/http'
require 'uri'

module Vatsim
  # Downloads and save status and vatsim data files
  class Status

    @@status_url = "http://status.vatsim.net/status.txt" # URL to retrieve vatsim status file
    @@status_download_interval = 60*60*6 # 6 hours
    @@vatsim_data_download_interval = 60*5 # 5 minutes

    # Default status file path
    STATUS_FILE_PATH = File.expand_path("../../../cache", __FILE__) + "/status.txt"
    # Default vatsim data file path
    VATSIMDATA_FILE_PATH = File.expand_path("../../../cache", __FILE__) + "/vatsim-data.txt"

    # Initialize the system by downloading status and vatsim data files
    def self.init

      if !File.exists?(STATUS_FILE_PATH) or File.mtime(STATUS_FILE_PATH) < Time.now - @@status_download_interval
        download_to_file @@status_url, STATUS_FILE_PATH
      end

      if !File.exists?(VATSIMDATA_FILE_PATH) or File.mtime(VATSIMDATA_FILE_PATH) < Time.now - @@vatsim_data_download_interval
        download_to_file random_data_url, VATSIMDATA_FILE_PATH
      end

    end

    private

    # Download a url to a file path
    def self.download_to_file url, file

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
    def self.random_data_url

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

