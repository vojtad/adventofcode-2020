class Map
  OPEN = '.'
  TREE = '#'

  attr_reader :height, :width

  def initialize
    @data = File.read('input.txt').split("\n").reject(&:empty?)
    @height = @data.size
    @width = @data.first.size
  end

  def at(right, down)
    @data[down][right % @width]
  end

  def tree_at?(right, down)
    at(right, down) == '#'
  end
end

current_x = 0
current_y = 0

step_x = 3
step_y = 1

trees = 0

map = Map.new
loop do
  break if current_y >= map.height

  trees += 1 if map.tree_at?(current_x, current_y)

  current_x += step_x
  current_y += step_y
end

pp trees
