require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Session < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'scur' => 'current',
            'smax' => 'max',
            'slim' => 'limit'
        }
        super(line)
      end
    end
  end
end
