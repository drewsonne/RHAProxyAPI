require './lib/RHAProxyAPI/Stats/base'
class RAHQueue < Base

  def initialize(line)
    @attr_map = {
      'qcur' => 'current',
      'qmax' => 'max',
      'qlimit' => 'limit'
    }
    super(line)
  end

end