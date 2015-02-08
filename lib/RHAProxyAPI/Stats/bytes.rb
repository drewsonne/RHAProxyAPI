require './lib/RHAProxyAPI/Stats/base.rb'

class Bytes < Base
  def initialize(line)
    @attr_map = {
      'bin' => 'in',
      'bout' => 'out'
    }
    super(line)
  end
end