module RHAProxyAPI
  class Executor

    SOCKET = 'socket'
    HTTP = 'http'

    @connection_string = ''
    @method
    @http_auth_username
    @http_auth_password
    @socket

    def initialize(connection_string, method)
      @connection_string = connection_string
      @method = method
    end

    public

    def set_credentials(username, password)
      @http_auth_username = username
      @http_auth_password = password
    end

    def dispatch_to_ha(ha_command)
      case @method
        when Executor::SOCKET
          ha_command.process_socket_response(execute_socket(ha_command))
        when Executor::HTTP
          ha_command.processHttpResponse(executeHttp(ha_command))
        else
          raise UnknownMethod, @method
      end
    end

    def execute_socket(command)
      open_socket{ |socket|
        socket.print "#{command.get_socket_command}\n"
        socket.close_write
        socket.read
      }
    end

    def open_socket

      if @connection_string.include? ':'
        protocol, hostname, port = @connection_string.split(':')
        hostname.gsub!(/\//, '')
        yield Socket.tcp(hostname, port.to_i)
      elsif File.new(@connection_string).socket?
        yield Socket.unix(@connection_string)
      else
        raise BadConnectionString, @connection_string
      end

    end

    def executeHttp(command)

      domain, port = @connection_string.match(/http\:\/\/([^\:]+):([^\/]+)/)

      data_model = command.get_http_command
      url = URI(@connection_string)
      if data_model.method == 'get'
        url.query = URI.encode_www_form(data_model.data)
        request = Net::HTTP::Get.new(url)
      elsif data_model.method == 'post'
        request = Net::HTTP::Post.new(uri)
      end
      request.basic_auth(@http_auth_username, @http_auth_password)

      response = Net::HTTP.start(domain, port) { |http|
        http.request(request)
      }
      response.body

    end

  end
end
