program = File.read(ARGV[0]).split("\n").map do |row|
  instruction, argument = row.split(' ')

  {
    i: instruction,
    a: argument.to_i
  }
end

def execute(program, replace_pc:, replace_instruction:)
pc = 0
acc = 0
x = []

loop do
  break if pc >= program.size

  pc_step = 1
  c = program[pc]

  instruction = c[:i]
  instruction = replace_instruction if pc == replace_pc

  return nil if x.include?(pc)
  x << pc

  case instruction
  when 'nop'
    # no-op
  when 'acc'
    acc += c[:a]
  when 'jmp'
    pc_step = c[:a]
  else
    raise 'unknown instruction'
  end

  pc += pc_step
end

acc
end

program.each_with_index do |c, pc|
  replace_instruction = case c[:i]
                        when 'nop'
                          'jmp'
                        when 'jmp'
                          'nop'
                        else
                          next
                        end

  next if c[:a] == 0

  pp [c, pc]
  result = execute(program, replace_pc: pc, replace_instruction: replace_instruction)
  next if result.nil?

  pp result
  break
end
