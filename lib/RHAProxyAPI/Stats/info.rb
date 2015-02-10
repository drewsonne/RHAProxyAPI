require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Info < RHAProxyAPI::Stats::Base
      TYPE_FRONTEND = 0
      TYPE_BACKEND = 1
      TYPE_SERVER = 2
      TYPE_SOCKET = 4

      def initialize(line)
        @attr_map = {
            'pxname'  => 'proxy_name',
            'svname'  => 'service_name',
            'weight'  => 'weight',
            'pid'     => 'process_id',
            'iid'     => 'proxy_id',
            'sid'     => 'service_id',
            'tracked' => 'tracked',
            'type'    => 'type'
        }
        super(line)
      end

      def is_frontend
        @type == Info::TYPE_FRONTEND
      end

      def is_backend
        @type == Info::TYPE_BACKEND
      end

      def is_server
        @type == Info::TYPE_SERVER
      end
    end
  end
end
