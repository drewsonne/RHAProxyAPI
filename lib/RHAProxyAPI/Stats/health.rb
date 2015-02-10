require 'RHAProxyAPI/stats'

module RHAProxyAPI
  module Stats
    class Health < RHAProxyAPI::Stats::Base
      def initialize(line)

        @check_status_desc = {
            'UNK' => 'unknown',
            'INI' => 'initializing',
            'SOCKERR' => 'socket error',
            'L4OK' => 'check passed on layer 4, no upper layers testing enabled',
            'L4TMOUT' => 'layer 1-4 timeout',
            'L4CON' => 'layer 1-4 connection problem, for example "Connection refused" (tcp rst) or "No route to host" (icmp)',
            'L6OK' => 'check passed on layer 6',
            'L6TOUT' => 'layer 6 (SSL) timeout',
            'L6RSP' => 'layer 6 invalid response - protocol error',
            'L7OK' => 'check passed on layer 7',
            'L7OKC' => 'check conditionally passed on layer 7, for example 404 with disable-on-404',
            'L7TOUT' => 'layer 7 (HTTP/SMTP) timeout',
            'L7RSP' => 'layer 7 invalid response - protocol error',
            'L7STS' => 'layer 7 response error, for example HTTP 5xx',
        }

        @attr_map = {
            'status' => 'status',
            'act' => 'active',
            'bck' => 'backup',
            'chkfail' => 'check_failed',
            'chkdown' => 'up_down_transitions',
            'lastchg' => 'status_change',
            'downtime' => 'downtime',
            'throttle' => 'throttle',
            'lbtot' => 'selected_total',
            'check_status' => 'check_status',
            'check_code' => 'check_code',
            'check_duration' => 'check_duration',
            'hanafail' => 'check_fail_details'
        }
        super(line)
      end

      public

      def get_check_status_description
        @check_status_desc[check_status]
      end
    end
  end
end
