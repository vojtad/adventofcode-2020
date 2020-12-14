preamble = ARGV[1].to_i
numbers = File.read(ARGV[0]).split("\n").map(&:to_i)

def find_prev_numbers(preamble, numbers, index)
  number = numbers[index]
  range = (index - preamble .. index - 1)
  
  numbers[range].each_with_index do |a, index_a|
    numbers[range].each_with_index do |b, index_b|
      next if index_a == index_b

      return [a, b] if a + b == number
    end
  end

  nil
end

bad_number = numbers[preamble + 1..].detect.with_index do |n, index|
  a, b = find_prev_numbers(preamble, numbers, index + preamble + 1)
  a.nil?
end

pp bad_number

def find_numbers_to_add_to_bad_number(bad_number, numbers, start_index)
  sum = 0
  index = start_index

  loop do
    sum += numbers[index]

    break if sum == bad_number
    return nil if sum > bad_number

    index += 1
  end

  numbers[start_index..index]
end

numbers.each_with_index do |n, start_index|
  next if n >= bad_number
  
  numbers_to_add = find_numbers_to_add_to_bad_number(bad_number, numbers, start_index)
  if numbers_to_add
    pp numbers_to_add.min + numbers_to_add.max

    break
  end
end

