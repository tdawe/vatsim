module Vatsim
  # Server to which clients can connect
  class Server

    attr_reader :ident, :hostname_or_IP, :location, :name, :clients_connection_allowed

    # Initialize Server with colon delimited line from vatsim-data.txt format
    def initialize line
      attributes = [:ident, :hostname_or_IP, :location, :name, :clients_connection_allowed]

      line_split = line.split(":")

      attributes.each_with_index.map { |attribute, index|
        instance_variable_set("@#{attribute}", line_split[index]) if self.respond_to?(attribute)
      }
    end
  end
end

