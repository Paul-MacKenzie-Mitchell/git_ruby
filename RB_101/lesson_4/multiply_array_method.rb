def multiply_nums(numbers, multiplier)
  product_numbers = []
  counter = 0
  loop do
    break if counter == numbers.length
    current_number = numbers[counter]
    product_numbers << numbers[counter] * multiplier
    counter += 1
  end
  product_numbers
  end
  
  my_numbers = [1, 4, 3, 7, 2, 6]
  
  p multiply_nums(my_numbers, 100)
  
  p my_numbers