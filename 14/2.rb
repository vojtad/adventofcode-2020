programs = File.read(ARGV[0]).split("mask = ").map do |program|
  next if program.empty?

  mask, *mem = program.split("\n")
  writes = mem.map do |line|
    match = line.match(/^mem\[(?<address>[0-9]+)\] = (?<value>[0-9]+)$/)
    { address: match[:address].to_i, value: match[:value].to_i }
  end
  
  {
    mask: mask,
    writes: writes
  }
end

programs.compact!

def apply_mask(value, mask)
  masked_value = value | mask.gsub('X', '0').to_i(2)
  masked_value = masked_value.to_s(2).rjust(36, '0')

  floating_bits = (0...mask.size).select { |i| mask[i] == 'X' }
  floating_bits.reduce([masked_value]) do |values, i|
    values.flat_map do |value|
      [
        value.dup.tap { |v| v[i] = '0' },
        value.dup.tap { |v| v[i] = '1' },
      ]
    end
  end
end

memory = programs.inject({}) do |memory, program|
  program[:writes].each do |write|
    apply_mask(write[:address], program[:mask]).each do |address|
      memory[address] = write[:value]
    end
  end

  memory
end

pp memory.values.reduce(:+)
