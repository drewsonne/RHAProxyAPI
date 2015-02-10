require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Rate < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'rate' => 'current',
            'rate_max' => 'max',
            'rate_lim' => 'limit'
        }
        super(line)
      end
    end
  end
end
