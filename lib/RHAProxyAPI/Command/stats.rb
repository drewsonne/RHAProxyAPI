require './lib/RHAProxyAPI/Command/base_obj.rb'
module Command
  class Stats < Command::BaseObj
    def get_socket_command
      'show stat'
    end
  end
end