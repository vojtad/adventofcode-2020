class Map
  TREE = '#'

  attr_reader :height, :width

  def initialize
    @data = File.read('input.txt').split("\n").reject(&:empty?)
    @height = @data.size
    @width = @data.first.size
  end

  def at(x, y)
    @data[y][x % @width]
  end

  def tree_at?(x, y)
    at(x, y) == TREE
  end

  def check_slope(right, down)
    current_x = 0
    current_y = 0

    trees = 0

    loop do
      break if current_y >= height

      trees += 1 if tree_at?(current_x, current_y)

      current_x += right
      current_y += down
    end

    trees
  end
end

map = Map.new

results = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
].map do |(right, down)|
  map.check_slope(right, down)
end

pp results.reduce(:*)
