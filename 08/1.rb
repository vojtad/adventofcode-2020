program = File.read(ARGV[0]).split("\n").map do |row|
  instruction, argument = row.split(' ')

  {
    i: instruction,
    a: argument.to_i,
    acc_values: []
  }
end

pc = 0
acc = 0

loop do
  pc_step = 1
  c = program[pc]

  break if c[:acc_values].size > 0

  case c[:i]
  when 'nop'
    # no-op
  when 'acc'
    acc += c[:a]
  when 'jmp'
    pc_step = c[:a]
  else
    raise 'unknown instruction'
  end

  c[:acc_values] << acc
  pc += pc_step
end

pp acc
