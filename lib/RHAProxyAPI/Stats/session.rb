require './lib/RHAProxyAPI/Stats/base.rb'

class Session < Base
  def initialize(line)
    @attr_map = {
      'scur' => 'current',
      'smax' => 'max',
      'slim' => 'limit'
    }
    super(line)
  end
end