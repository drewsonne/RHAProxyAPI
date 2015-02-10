require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Error < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'ereq' => 'requests',
            'eresp' => 'responses',
            'econ' => 'connections'
        }
        super(line)
      end
    end
  end
end
