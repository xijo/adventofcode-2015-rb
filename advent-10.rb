result = [1, 1, 1, 3, 1, 2, 2, 1, 1, 3]
# result = [1]

311311222113

50.times do
  new_result = []

  until result.empty? do
    count         = 1
    current_value = result.shift

    while result[0] == current_value
      result.shift
      count += 1
    end

    new_result << count
    new_result << current_value
  end

  result = new_result
end

puts result.join.size
