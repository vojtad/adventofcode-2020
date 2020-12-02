lines = File.read('input.txt').split("\n")
d = lines.map do |line|
  policy, letter, password = line.split(' ')
  
  first_pos, second_pos = policy.split('-').map(&:to_i)
  letter = letter.chop

  first = password[first_pos - 1]
  second = password[second_pos - 1]

  first != second && (first ==letter || second == letter) ? 1 : 0
end

pp d.reduce(:+)
