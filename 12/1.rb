class Rotation
  DIRECTIONS = {
    'N' => 0,
    'S' => 180,
    'E' => 90,
    'W' => 270
  }

  def initialize
    @direction = DIRECTIONS['E']
    @x = 10
    @y = 1
  end

  def one_d_y(direction = nil)
    Math.cos((DIRECTIONS[direction] || @direction) * Math::PI / 180).round
  end

  def d_y
    one_d_y == 0 ? @y : @y * one_d_y
  end

  def one_d_x(direction = nil)
    -1 * Math.sin((DIRECTIONS[direction] || @direction) * Math::PI / 180).round
  end

  def d_x
    one_d_x == 0 ? @x : @x * one_d_x
  end

  def one_d_xy(direction = nil)
    [one_d_x(direction), one_d_y(direction)]
  end

  def move_waypoint(direction, value)
    @x += one_d_x(direction) * value
    @y += one_d_y(direction) * value

    pp ['move_wp', @x, @y]
  end

  def turn(action, value)
    case action
    when 'L'
      @direction += value
    when 'R'
      @direction -= value
    end

    @x, @y = @y, @x if (value / 90) % 2 == 1

    pp ['turn', @x, @y, d_x, d_y]
  end
end

class Boat
  def initialize
    @waypoint_rotation = Rotation.new
    @x = 0
    @y = 0
  end

  def move_to_waypoint
    @x += @waypoint_rotation.d_x
    @y += @waypoint_rotation.d_y
    pp ["move", @waypoint_rotation.d_x, @waypoint_rotation.d_y, @x, @y]
  end

  def move(action, value)
    pp [action, value]
    case action
    when 'N', 'S', 'W', 'E'
      @waypoint_rotation.move_waypoint(action, value)
    when 'F'
      value.times { move_to_waypoint }
    when 'L', 'R'
      @waypoint_rotation.turn(action, value)
    end

    self
  end

  def result
    @x.abs + @y.abs
  end
end

boat = File.read(ARGV[0]).split("\n").map { |line| [line[0], line[1..].to_i] }.inject(Boat.new) { |boat, (action, value)| boat.move(action, value) }
puts boat.result

