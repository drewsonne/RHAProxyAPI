module RHAProxyAPI
  module Exception

    class BadHTTPResponse < IOError
      def initialize(code)
        super("Bad HTTP Response: HTTP '#{code}'")
      end
    end

    class BadConnectionString < ArgumentError
      def initialize(connection_string)
        super("Bad connection string: '#{connection_string}'")
      end
    end

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
