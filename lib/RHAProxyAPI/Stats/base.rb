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
      instance_variable_set("@#{property}", @line.get(raw_name))
    }
  end

end