module Vatsim
  class Data
    
    @@clients = Array.new
    
    def self.parse_clients

      if @@clients.length == 0
        Vatsim::Status.init
              
        parsing = false
  
        File.open(Vatsim::Status::VATSIMDATA_FILE_PATH, 'r:ascii-8bit').each { |line|
  
          parsing = false if parsing and line.start_with? ";"
  
          if parsing
            @@clients << Client.new(line)
          end
          
          parsing = true if line.start_with? "!CLIENTS:"
        }
      end
      
      return @@clients
      
    end
  end
end
