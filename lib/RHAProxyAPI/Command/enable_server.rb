require './lib/RHAProxyAPI/Command/base_obj.rb'
module Command
  class EnableServer < Command::BaseObj

    @backend
    @server
    @action

    def initialize(backend, server)
      @backend = backend
      @server = server
      @action = 'enable'
    end

    def get_socket_command
      "#{@action} server #{@backend}/#{@server}"
    end

  end
end