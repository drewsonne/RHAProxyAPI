require './lib/RHAProxyAPI/Stats/base.rb'

class Abort < Base
  def initialize(line)
    @attr_map = {
      'cli_abrt' => 'client',
      'srv_abrt' => 'server'
    }
    super(line)
  end
end