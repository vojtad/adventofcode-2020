REQUIRED_FIELDS = %w[byr iyr eyr hgt hcl ecl pid]
OPTIONAL_FIELDS = %w[cid]

def hgt_valid?(hgt)
  units = hgt[-2..-1]
  case units
  when 'cm'
    (150..193).include?(hgt.to_i)
  when 'in'
    (59..76).include?(hgt.to_i)
  else
    false
  end
end

def field_valid?(field, value)
  return false if value.nil?

  case field
  when 'byr'
    value.match(/^[0-9]{4}$/) && (1920..2002).include?(value.to_i)
  when 'iyr'
    value.match(/^[0-9]{4}$/) && (2010..2020).include?(value.to_i)
  when 'eyr'
    value.match(/^[0-9]{4}$/) && (2020..2030).include?(value.to_i)
  when 'hgt'
    hgt_valid?(value)
  when 'hcl'
    value.match(/^#[0-9a-f]{6}$/)
  when 'ecl'
    %w[amb blu brn gry grn hzl oth].include?(value)
  when 'pid'
    value.match(/^[0-9]{9}$/)
  when 'cid'
    true
  else
    false
  end
end

valid = File.read('input.txt').split("\n\n").map do |data|
  passport = data.split(/[[:space:]]/).map { |pair| pair.split(':') }.to_h
  
  valid = REQUIRED_FIELDS.all? do |field|
    field_valid?(field, passport[field])
  end

  valid ? 1 : 0
end

pp valid.reduce(:+)
