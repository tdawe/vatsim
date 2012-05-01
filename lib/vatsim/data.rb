module Vatsim
  class Data

    @@clients = Array.new
    @@prefile = Array.new

    def self.clients
      self.parse
      return @@clients
    end

    def self.prefile
      self.parse
      return @@prefile
    end

    def self.parse

      if @@clients.length == 0
        Vatsim::Status.init

        parsing_clients = false
        parsing_prefile = false

        File.open(Vatsim::Status::VATSIMDATA_FILE_PATH, 'r:ascii-8bit').each { |line|

          parsing_clients = false if line.start_with? ";"
          parsing_prefile = false if line.start_with? ";"

          if parsing_clients
            @@clients << Client.new(line)
          elsif parsing_prefile
            @@prefile << Prefile.new(line)
          end

          parsing_clients = true if line.start_with? "!CLIENTS:"
          parsing_prefile = true if line.start_with? "!PREFILE:"
        }
      end
    end
  end
end

