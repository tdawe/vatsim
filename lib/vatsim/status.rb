require 'net/http'
require 'uri'

module Vatsim
  class Status

    @@status_download_interval = 60*60*6 # 6 hours
    @@vatsim_data_download_interval = 60*5 # 5 minutes
    
    STATUS_FILE_PATH = File.expand_path("../../../cache", __FILE__) + "/status.txt"
    VATSIMDATA_FILE_PATH = File.expand_path("../../../cache", __FILE__) + "/vatsim-data.txt"
        
    def self.download

      if !File.exists?(STATUS_FILE_PATH) or File.mtime(STATUS_FILE_PATH) < Time.now - @@status_download_interval 
        File.new(STATUS_FILE_PATH, File::CREAT)
	Net::HTTP.start("status.vatsim.net") { |http|
       	  resp = http.get("/status.txt")
          open(STATUS_FILE_PATH, "wb") { |file|
            file.write(resp.body)
          }
        }
      end
    end
    
    def self.parse
      url0s = Array.new
      file = File.open(STATUS_FILE_PATH)
      file.each {|line|
        if line.start_with? "url0"
          url0s << line.split("=").last
        end
      }
      url = URI.parse(URI.encode(url0s[rand(url0s.length)].strip!))
if !File.exists?(VATSIMDATA_FILE_PATH) or File.mtime(VATSIMDATA_FILE_PATH) < Time.now - @@vatsim_data_download_interval      
    File.new(VATSIMDATA_FILE_PATH, File::CREAT)
    Net::HTTP.start(url.host) { |http|
      resp = http.get(url.path)
      open(VATSIMDATA_FILE_PATH, "wb") { |file|
        file.write(resp.body)
      }
    }
     end 
    end
  end
end
