lines = File.read('input.txt').split("\n")
d = lines.map do |line|
  policy, letter, password = line.split(' ')
  
  min, max = policy.split('-').map(&:to_i)
  letter = letter.chop
  
  count = password.count(letter)
  
  (min..max).include?(count) ? 1 : 0
end

pp d.reduce(:+)
