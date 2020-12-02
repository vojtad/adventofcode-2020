expenses = File.read('input.txt').split.map(&:to_i)

expenses.each_with_index do |first, first_index|
  expenses.each_with_index do |second, second_index|
    next if first_index == second_index

    expenses.each_with_index do |third, third_index|
      next if first_index == third_index
      next if second_index == third_index

      if first + second + third == 2020
        values = [first, second, third]
        pp values
        pp values.reduce(:*)

        exit(0)
      end
    end
  end
end

