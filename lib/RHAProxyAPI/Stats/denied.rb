require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Denied < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'dreq' => 'requests',
            'dresp' => 'responses'
        }
        super(line)
      end
    end
  end
end
