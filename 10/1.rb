bag = [0] + File.read(ARGV[0]).split("\n").map(&:to_i).sort
bag << bag.max + 3

differences = bag.map.with_index do |adapter, index|
  next if index >= (bag.length - 1)
  
  bag[index + 1] - adapter
end

pp differences.compact.group_by(&:itself).transform_values(&:count).values.reduce(:*)

def find_candidates(bag, index)
  max_candidate = bag[index] + 3
  candidates = []

  c_index = index + 1
  loop do
    c = bag[c_index]
    break if c.nil? || c > max_candidate

    candidates << [c, c_index]
    c_index += 1
  end

  candidates
end

def make_a_wish(bag, current_index, cache)
  return 1 if current_index >= (bag.size - 1)

  candidates = find_candidates(bag, current_index)
  return 0 if candidates.empty?
  
  cache[current_index] ||= begin
                             counts = candidates.map do |(c, c_index)|
                               make_a_wish(bag, c_index, cache)
                             end

                             counts.reduce(:+)
                           end
end

pp make_a_wish(bag, 0, {})
