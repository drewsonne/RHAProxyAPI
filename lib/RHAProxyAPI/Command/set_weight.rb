require 'RHAProxyAPI/command'

module RHAProxyAPI
  module Command
    class SetWeight < RHAProxyAPI::Command::Base
      @backend
      @server
      @weight

      # For now, we assume weight is an absolute amount, and
      # does NOT use the relative % modifier as per
      # http://cbonte.github.io/haproxy-dconv/configuration-1.5.html#9.2-set%20weight
      def initialize(backend, server, weight)
        @backend = escape(backend)
        @server = escape(server)
        @weight = weight.to_i
      end

      def get_socket_command
        "set weight #{@backend}/#{@server} #{weight}"
      end
    end
  end
end
