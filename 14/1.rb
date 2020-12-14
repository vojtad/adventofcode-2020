memory = File.read(ARGV[0]).split("mask = ").reduce({}) do |memory, program|
  next memory if program.empty?

  mask, *mem = program.split("\n")

  and_mask = mask.gsub('X', '1').to_i(2)
  or_mask = mask.gsub('X', '0').to_i(2)

  mem.each do |line|
    match = line.match(/^mem\[(?<address>[0-9]+)\] = (?<value>[0-9]+)$/)
    memory[match[:address].to_i] = (match[:value].to_i & and_mask) | or_mask
  end

  memory
end

puts memory.values.reduce(:+)
