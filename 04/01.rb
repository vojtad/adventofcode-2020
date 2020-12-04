REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid]
OPTIONAL_FIELDS = %w[cid]

valid = File.read('input.txt').split("\n\n").map do |data|
  passport = data.split(/[[:space:]]/).map { |pair| pair.split(':') }.to_h
  (passport.keys & REQUIRED_FIELDS).size == REQUIRED_FIELDS.size ? 1 : 0
end

pp valid.reduce(:+)
