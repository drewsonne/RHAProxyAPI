require "RHAProxyAPI/version"


require 'RHAProxyAPI/Stats/line_collection'
require 'RHAProxyAPI/Stats/service_obj'
require 'RHAProxyAPI/exception'
require 'RHAProxyAPI/Command/stats'

module HAProxyAPI

  class Stats

    attr_reader :proxy_tree

    def initialize
      @proxy_tree = {}
    end

    def set_from_stats(raw_stats)
      if raw_stats.is_a?(String)
        stats = LineCollection.new(raw_stats)
      elsif raw_stats.is_a?(LineCollection)
        stats = raw_stats
      else
        raise "Unexpected stats type."
      end

      @proxy_tree = []

      stats.each { |stats_line|
        service = RHAProxyAPI::Stats::ServiceObj.new(stats_line)
        if @proxy_tree.include?(service.info.proxy_name)
          @proxy_tree[service.info.proxy_name][service.info.service_name] = service
        else
          @proxy_tree[service.info.proxy_name] = { service.info.service_name => service }
        end
      }

      self

    end

    def backend_exists(backend)
      return @proxy_tree.include?(backend)
    end

    def server_exists(backend, server)
      backend_exists(backend) && @proxy_tree[backend].include?(server)
    end

    def get_backend_services(backend)
      raise MissingBackend, backend unless backend_exists(backend)
      @proxy_tree[backend]
    end

    def get_service_stats(backend, server)
      raise MissingBackend, backend unless backend_exists(backend)
      raise MissingServer, service unless server_exists(backend, server)
      @proxy_tree[backend][server]
    end

    def get_backend_names
      @proxy_tree.keys
    end

    def get_server_names(backend)
      raise MissingBackend, backend unless backend_exists(backend)
      @proxy_tree[backend].keys
    end

    def self.get(exec)
      self.new.set_from_stats(exec.execute(Command::Stats.new))
    end

  end

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

    def set_credentials(username, password)
      @http_auth_username = username
      @http_auth_password = password
    end

    def execute(command)
      case @method
        when self::SOCKET; then command.processSocketResponse(executeSocket(command))
        when self::HTTP; then command.processHttpResponse(executeHttp(command))
        else raise UnknownMethod, @method
      end
    end

    def execute_socket(command)
      open_socket { |socket|
        socket.print "#{command.get_socket_command}\n"
        socket.close_write
        socket.read
      }
    end

    def open_socket(&response_processing)

      if @connection_string.include? ':'
        hostname, port = @connection_string.split(':')
        Socket.tcp(hostname, port) &response_processing

      elsif File.new(@connection_string).socket?
        Socket.unix(@connection_string) &response_processing

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
