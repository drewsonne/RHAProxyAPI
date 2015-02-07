require './lib/RHAProxyAPI/exception.rb'

class Line

  @data = {}

  def initialize(columns, line)
    values = line.split(',')

    # raise RHAException::ColumnCountMismatch, columns.length, values.length if values.length != columns.length

    @data = Hash[columns.zip values]
    self

  end

end