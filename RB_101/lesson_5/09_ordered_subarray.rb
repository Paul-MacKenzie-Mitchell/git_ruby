arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

sorted_array = arr.map do |arr|
  arr.sort do |a, b|
    b <=> a
  end
end

p sorted_array