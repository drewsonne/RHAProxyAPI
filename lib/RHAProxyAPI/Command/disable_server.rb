require 'RHAProxyAPI/Command/enable_server'

module RHAProxyAPI
  module Command
    class DisableServer < RHAProxyAPI::Command::EnableServer
      def initialize(server, backend)
        super(server, backend)
        @action = 'disable'
      end
    end
  end
end
