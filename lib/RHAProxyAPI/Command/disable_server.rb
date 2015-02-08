require './lib/RHAProxyAPI/Command/base_obj.rb'

module Command

  class DisableServer < Command::BaseObj
    def initialize(server, backend)
      super(server, backend)
      @action = 'disable'
    end
  end

end
