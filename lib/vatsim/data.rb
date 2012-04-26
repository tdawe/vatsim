module Vatsim
  class Data
    def self.parse_clients

      Vatsim::Status.download
      Vatsim::Status.parse
            
      clients = Array.new

      parsing = false

      File.open(Vatsim::Status::VATSIMDATA_FILE_PATH, 'r:ascii-8bit').each { |line|

        parsing = false if parsing and line.start_with? ";"

        if parsing
          clients << Client.new(line)
        end
        
        parsing = true if line.start_with? "!CLIENTS:"
      }
      
      return clients
      
    end
  end
end