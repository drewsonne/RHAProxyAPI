module RHAProxyAPI
  module Exception

    class UnknownMethod < ArgumentError
      def initialize(method_name)
        super("Unexpected connection method: '#{method_name}'.")
      end
    end

    class MissingBackend < ArgumentError
      def initialize(backend_name)
        super("Backend does not exist: '#{backend_name}'.")
      end
    end

    class MissingServer < ArgumentError
      def initialize(backend_name)
        super("Server does not exist: '#{backend_name}'.")
      end
    end

  end
end
