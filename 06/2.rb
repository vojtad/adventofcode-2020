counts = File.read('input.txt').split("\n\n").map do |group|
  people_answers = group.split("\n")
  person_count = people_answers.size

  answers = people_answers.flat_map { |answer| answer.split('') }.group_by(&:itself)
  answers.select { |_, x| x.size == person_count }.size
end

pp counts.reduce(:+)
