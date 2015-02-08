require './lib/RHAProxyAPI/Stats/base.rb'

class Error < Base
  def initialize(line)
    @attr_map = {
      'ereq' => 'requests',
      'eresp' => 'responses',
      'econ' => 'connections'
    }
    super(line)
  end
end