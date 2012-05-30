module Vatsim
  # Voice server that clients can use
  class VoiceServer

    attr_reader :hostname_or_IP, :location, :name, :clients_connection_allowed, :type_of_voice_server

    # Initialize Server with colon delimited line from vatsim-data.txt format
    def initialize line
      attributes = [:hostname_or_IP, :location, :name, :clients_connection_allowed, :type_of_voice_server]

      line_split = line.split(":")

      attributes.each_with_index.map { |attribute, index|
        instance_variable_set("@#{attribute}", line_split[index]) if self.respond_to?(attribute)
      }
    end
  end
end

