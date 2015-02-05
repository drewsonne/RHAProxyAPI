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
    def execute(command)

    end
  end

end
