require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class HttpResponseCode < RHAProxyAPI::Stats::Base
      def initialize(line)
        @attr_map = {
            'hrsp_1xx' => 'http_1xx',
            'hrsp_2xx' => 'http_2xx',
            'hrsp_3xx' => 'http_3xx',
            'hrsp_4xx' => 'http_4xx',
            'hrsp_5xx' => 'http_5xx'
        }
        super(line)
      end
    end
  end
end
