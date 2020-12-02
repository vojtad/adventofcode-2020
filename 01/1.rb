def find_it(expenses, current_index)
  return nil if current_index >= expenses.size

  current_expense = expenses[current_index]

  expenses.each_with_index do |expense, index|
    next if current_index == index

    return [current_expense, expense] if current_expense + expense == 2020
  end

  find_it(expenses, current_index + 1)
end

expenses = File.read('input.txt').split.map(&:to_i)

pair = find_it(expenses, 0)
pp pair

a, b = pair
pp a * b
