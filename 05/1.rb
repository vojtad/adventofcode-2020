input = File.read('input.txt').split("\n")

def half(range, instruction, lower:, upper:)
  middle = range.min + (range.max - range.min) / 2
  case instruction
  when lower
    (range.min..middle)
  when upper
    (middle + 1..range.max)
  end
end

def find(range, instructions, lower:, upper:, final:)
  instructions.each_char do |i|
    range = half(range, i, lower: lower, upper: upper)
  end
  
  range.send(final)
end

seats = input.map do |boarding_pass|
  row = find((0..127), boarding_pass[0..6], lower: 'F', upper: 'B', final: :min)
  column = find((0..7), boarding_pass[7..9], lower: 'L', upper: 'R', final: :max)

  row * 8 + column
end

# part one
pp seats.max

# part two
candidates = (0..(127 * 8 + 7)).entries - seats
pp candidates.select { |seat| seats.include?(seat - 1) && seats.include?(seat + 1) }
