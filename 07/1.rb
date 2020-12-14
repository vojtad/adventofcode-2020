def parent_bag_options(rules, bag)
  matched_rules = rules.select do |parent_bag, parent_bag_rules|
    parent_bag_rules.include?(bag)
  end

  return nil if matched_rules.size == 0

  matched_rules.flat_map do |rule_pair|
    [[rule_pair[0], bag]] + (parent_bag_options(rules, rule_pair[0])&.map { |p| p + [bag] } || [])
  end
end

def child_bag_count(rules, bag)
  counts = rules[bag]&.map do |(child_bag, count)|
    count * child_bag_count(rules, child_bag)
  end

  (counts&.reduce(:+) || 0) + 1
end

rules = File.read(ARGV.first).split("\n").map do |line|
  container, rules = line.split('contain').map(&:strip)
  container.sub!(/ bags$/, '')

  bag_rules = rules.chop.split(',').map(&:strip).map do |rule|
    number = rule.to_i
    next if number == 0

    color = rule.sub(/^[0-9]* /, '').sub(/ bags?$/, '')
    [color, number]
  end

  [container, bag_rules.reject { |r| r.nil? }.to_h]
end

rules = rules.to_h

options = parent_bag_options(rules, 'shiny gold')
pp options.group_by { |o| o[0] }.keys.size

pp child_bag_count(rules, 'shiny gold') - 1
