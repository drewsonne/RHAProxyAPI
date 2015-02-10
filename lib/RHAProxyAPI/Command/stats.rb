require 'RHAProxyAPI/command'

module RHAProxyAPI
  module Command
    class Stats < RHAProxyAPI::Command::Base
      def get_socket_command
        'show stat'
      end
    end
  end
end
