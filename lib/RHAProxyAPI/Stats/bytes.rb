require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Bytes < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'bin' => 'in',
            'bout' => 'out'
        }
        super(line)
      end
    end
  end
end
