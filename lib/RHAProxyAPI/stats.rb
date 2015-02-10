module RHAProxyAPI
  module Stats
    class StatsDispatcher

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

        @proxy_tree = {}

        stats.each { |stats_line|
          service = ServiceObj.create_from_line(stats_line)
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
        new_command_stats = Command::Stats.new
        stats_from_exec = exec.dispatch_to_ha(new_command_stats)
        self.new.set_from_stats(stats_from_exec)
      end

    end

    class Base
      @line
      attr_accessor :attr_map

      def initialize(line)
        @line = line
        assign_values
      end

      private

      def assign_values
        @attr_map.each {|raw_name, property|
          self.class.send(:attr_accessor, property)
          instance_variable_set("@#{property}", @line.get(raw_name))
        }
      end

    end
  end

end
