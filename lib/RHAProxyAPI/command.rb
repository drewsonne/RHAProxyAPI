module RHAProxyAPI
  module Command
    class Base

      public

      # Implemented in subclasses
      def get_socket_command
        throw NotImplementedError
      end

      # Implemented in subclasses
      def get_http_command
        throw NotImplementedError
      end

      def process_http_response(response)
        response_lines = response.split(/[\n\r]+/)
        http_code = get_http_code(response)
        if http_code >= 400
          throw new BadHTTPResponse, http_code
        end

        get_response_message(response_lines)
      end

      # Escapes variabes to be used as strings in commands.
      # See: http://cbonte.github.io/haproxy-dconv/configuration-1.5.html#2.1
      def escape(value)
        raise SecurityError, "';' is not allowed in arguments passed to commands." if value.include?(';')
        value.gsub(/\s+/, '\ ').gsub(/\\/, '\\').gsub(/\//, '\/')
      end

      private

      def get_http_code(response_lines)
        return 200
      end



    end

  end
end
