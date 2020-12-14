group_counts = File.read('input.txt').split("\n\n").map do |group|
  group.split("\n").flat_map { |answer| answer.split('') }.uniq.count
end

pp group_counts.reduce(:+)
