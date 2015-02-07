require './lib/RHAProxyAPI/Stats/line.rb'

class LineCollection

  @lines = []
  @columns = []
  @storage = []
  @iter_index = 0

  def initialize(raw_stats)
    # Split the raw stats into lines
    raw_lines = raw_stats.split(/\r?\n/)
    # Remove garbage from header column, and then seperate into column names
    @columns = raw_lines.shift.sub(/^[# ]+/, '').split(',')
    # Create new line objects from each of the stats lines
    @lines = raw_lines.map { |line|
      Line.new(@columns, line)
    }.compact
  end

  def each(&block)
    @lines.each { |line|
        yield line
    }
  end

end
