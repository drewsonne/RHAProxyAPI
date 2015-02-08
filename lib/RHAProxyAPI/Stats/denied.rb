require './lib/RHAProxyAPI/Stats/base.rb'

class Denied < Base
  def initialize(line)
    @attr_map = {
      'dreq' => 'requests',
      'dresp' => 'responses'
    }
    super(line)
  end
end