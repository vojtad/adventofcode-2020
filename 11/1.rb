layout = File.read(ARGV[0]).split("\n")
width = layout[0].size
height = layout.size

def occupied_in_direction?(layout, x, y, d_x, d_y)
  c_x = x
  c_y = y

  loop do
    c_x += d_x
    c_y += d_y

    return false if c_y < 0 || c_y >= layout.size
    return false if c_x < 0 || c_x >= layout[0].size

    return true if layout[c_y][c_x] == '#'
    return false if layout[c_y][c_x] == 'L'
  end
end

def can_become_occupied?(layout, x, y)
  return false if layout[y][x] != 'L'

  (-1..1).each do |d_y|
    next if y + d_y < 0 || y + d_y >= layout.size

    (-1..1).each do |d_x|
      next if x + d_x < 0 || x + d_x >= layout[y + d_y].size

      return false if occupied_in_direction?(layout, x, y, d_x, d_y)
    end
  end

  true
end

def can_become_empty?(layout, x, y)
  return false if layout[y][x] != '#'

  adjacent_occupied = 0
  (-1..1).each do |d_y|
    next if y + d_y < 0 || y + d_y >= layout.size

    (-1..1).each do |d_x|
      next if d_y == 0 && d_x == 0
      next if x + d_x < 0 || x + d_x >= layout[y + d_y].size

      adjacent_occupied += 1 if occupied_in_direction?(layout, x, y, d_x, d_y)

      return true if adjacent_occupied >= 5
    end
  end

  false
end

def step(initial_layout)
  layout = Marshal.load(Marshal.dump(initial_layout))

  (0...layout.size).each do |y|
    (0...layout[0].size).each do |x|
      if can_become_occupied?(initial_layout, x, y)
        layout[y][x] = '#'
      elsif can_become_empty?(initial_layout, x, y)
        layout[y][x] = 'L'
      end
    end
  end

  layout
end

def are_layouts_the_same?(a, b)
  (0...a.size).each do |y|
    (0...a[0].size).each do |x|
      return false if a[y][x] != b[y][x]
    end
  end

  true
end

steps = 0

loop do
  new_layout = step(layout)
  steps += 1

  if are_layouts_the_same?(layout, new_layout)
    layout = new_layout
    break
  end

  layout = new_layout
end

puts steps
puts layout
puts layout.map { |y| y.count('#') }.reduce(:+)
