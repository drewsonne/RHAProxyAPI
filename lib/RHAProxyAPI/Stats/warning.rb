require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Warning < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'wretr' => 'retries',
            'wredis' => 'redispatches'
        }
        super(line)
      end
    end
  end
end
