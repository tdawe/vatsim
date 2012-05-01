module Vatsim
  class Data

    @@clients = Array.new
    @@prefile = Array.new
    @@general = Hash.new

    def self.clients
      self.parse
      return @@clients
    end

    def self.prefile
      self.parse
      return @@prefile
    end

    def self.general
      self.parse
      return @@general
    end

    def self.parse

      if @@clients.length == 0
        Vatsim::Status.init

        parsing_clients = false
        parsing_prefile = false
        parsing_general = false

        File.open(Vatsim::Status::VATSIMDATA_FILE_PATH, 'r:ascii-8bit').each { |line|

          parsing_clients = false if line.start_with? ";"
          parsing_prefile = false if line.start_with? ";"
          parsing_general = false if line.start_with? ";"

          if parsing_clients
            @@clients << Client.new(line)
          elsif parsing_prefile
            @@prefile << Prefile.new(line)
          elsif parsing_general
            line_split = line.split("=")
            @@general[line_split[0].strip.downcase.gsub(" ", "_")] = line_split[1].strip
          end

          parsing_clients = true if line.start_with? "!CLIENTS:"
          parsing_prefile = true if line.start_with? "!PREFILE:"
          parsing_general = true if line.start_with? "!GENERAL:"
        }
      end
    end
  end
end

