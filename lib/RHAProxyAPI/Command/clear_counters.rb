require './lib/RHAProxyAPI/Command/base_obj.rb'
module Command
  class ClearCounters < Command::BaseObj

    @all

    def initialize(all=false)
      @all = all
    end

    def get_socket_command
      "clear counters #{@all ? ' all' : '' }"
    end
  end
end