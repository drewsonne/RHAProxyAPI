module RHAProxyAPI
  module Command
    class Base
      @response_map = {
          :DONE => 'Action processed successfully.',
          :NONE => 'Nothing has changed.',
          :EXCD => 'Action not processed: the buffer couldn\'t store all the data. You should retry with less servers at a time.',
          :DENY => 'Action denied.',
          :UNKN => 'Unexpected error.'
      }

      public

      def get_socket_command
        throw NotImplementedError
      end

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

      def process_socket_response(response)
        response
      end

      private

      def get_http_code(response_lines)
        return 200
      end

      def get_response_messages(response_lines)
        response = 'Unable to parse server response'
        response_lines.each { |line|
          matches = line.match(/^[Ll]ocation.+;st=(DONE|NONE|EXCD|DENY|UNKN)/)
          if matches.length > 0
            response = @response_map[matches[0]]
            break;
          end
        }

        response
      end
    end

  end
end
