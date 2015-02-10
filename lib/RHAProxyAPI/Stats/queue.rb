require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Queue < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'qcur' => 'current',
            'qmax' => 'max',
            'qlimit' => 'limit'
        }
        super(line)
      end
    end
  end
end
