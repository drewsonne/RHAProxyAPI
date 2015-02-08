require './lib/RHAProxyAPI/Stats/base.rb'

class Warning < Base
  def initialize(line)
    @attr_map = {
      'wretr' => 'retries',
      'wredis' => 'redispatches'
    }
    super(line)
  end
end