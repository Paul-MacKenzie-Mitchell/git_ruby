arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]
# [[1, 8, 3], [1, 5, 9], [6, 1, 7], [1, 6, 9]]
array1 = arr.sort_by do |array|
  array.select do |num|
    num % 2 == 1
    # or num.odd?
  end
end

p array1