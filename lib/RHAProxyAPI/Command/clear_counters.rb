require 'RHAProxyAPI/command'

module RHAProxyAPI
  module Command
    class ClearCounters < RHAProxyAPI::Command::Base

      @all

      def initialize(all=false)
        @all = all
      end

      def get_socket_command
        "clear counters #{@all ? ' all' : '' }"
      end
    end
  end
end
