require 'RHAProxyAPI/command'

module RHAProxyAPI
  module Command
    class EnableServer < RHAProxyAPI::Command::Base

      @backend
      @server
      @action

      def initialize(backend, server)
        @backend = escape(backend)
        @server = escape(server)
        @action = 'enable'
      end

      def get_socket_command
        "#{@action} server #{@backend}/#{@server}"
      end

    end
  end
end
