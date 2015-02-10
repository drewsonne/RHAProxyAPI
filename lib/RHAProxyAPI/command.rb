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

      private

      def get_http_code(response_lines)
        return 200
      end

    end

  end
end
