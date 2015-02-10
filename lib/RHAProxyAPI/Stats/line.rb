module RHAProxyAPI
  module Stats
    class Line
      @data = {}

      def initialize(columns, line)
        values = line.split(',')

        # raise RHAException::ColumnCountMismatch, columns.length, values.length if values.length != columns.length

        @data = Hash[columns.zip values]
        self

      end

      def get(variable_name)
        @data[variable_name]
      end
    end
  end
end
