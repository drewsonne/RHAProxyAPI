require './lib/RHAProxyAPI/Stats/info.rb'
require './lib/RHAProxyAPI/Stats/health.rb'
require './lib/RHAProxyAPI/Stats/rah_queue.rb'
require './lib/RHAProxyAPI/Stats/session.rb'
require './lib/RHAProxyAPI/Stats/bytes.rb'
require './lib/RHAProxyAPI/Stats/rate.rb'
require './lib/RHAProxyAPI/Stats/abort.rb'
require './lib/RHAProxyAPI/Stats/denied.rb'
require './lib/RHAProxyAPI/Stats/error.rb'
require './lib/RHAProxyAPI/Stats/warning.rb'
require './lib/RHAProxyAPI/Stats/http_response_code.rb'

class ServiceObj
  attr_accessor :info
  attr_accessor :info
  attr_accessor :health
  attr_accessor :queue
  attr_accessor :session
  attr_accessor :bytes
  attr_accessor :rate
  attr_accessor :abort
  attr_accessor :denied
  attr_accessor :error
  attr_accessor :warning
  attr_accessor :http_response_code

  def self.create_from_line(line)
    instance = self.new
    instance.set_from_line(line)
  end

  def set_from_line(line)
    @info = Info.new(line)
    @health = Health.new(line)
    @queue = RAHQueue.new(line)
    @session = Session.new(line)
    @bytes = Bytes.new(line)
    @rate = Rate.new(line)
    @abort = Abort.new(line)
    @denied = Denied.new(line)
    @error = Error.new(line)
    @warning = Warning.new(line)
    @http_response_code = HttpResponseCode.new(line)
    self
  end

end
