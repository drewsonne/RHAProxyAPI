require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Abort < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'cli_abrt' => 'client',
            'srv_abrt' => 'server'
        }
        super(line)
      end
    end
  end
end
