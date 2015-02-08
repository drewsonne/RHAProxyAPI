require './lib/RHAProxyAPI/Stats/base.rb'

class Rate < Base
  def initialize(line)
    @attr_map = {
      'rate' => 'current',
      'rate_max' => 'max',
      'rate_lim' => 'limit'
    }
    super(line)
  end
end