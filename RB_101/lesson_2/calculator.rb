answer =nil
num_1 = nil
num_2 = nil
while answer == nil
test_array = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
#ask the user for two numbers
  

  while test_array.include?(num_1) == false
    puts "Please enter your first of two numbers to perform an operation on: "
    num_1 = gets.chomp
  end
  while test_array.include?(num_2) == false
    puts "Please enter your second of two numbers to perform an operation on: "
    num_2 = gets.chomp
  end


#ask the user for an operation to perform
  puts "Please enter an operation to perform ( +, -, *, /)"
  operation = gets.chomp.to_s
#perform the operation on the numbers

  if operation == "+"
    answer = num_1 + num_2
  elsif operation == "-"
    answer = num_1 - num_2
  elsif operation == "*"
    answer = num_1 * num_2
  elsif operation == "/"
    num_1 = num_1.to_f
    num_2 = num_2.to_f
    while num_2 == 0.0
      puts "Cannot divide by 0, please enter a valid denominator"
      num_2 = gets.chomp.to_f
    end
    answer = num_1 / num_2
  else
    puts "Your input operation is invalid"
  end
end
#outut the results
puts "#{num_1} #{operation} #{num_2} is #{answer}"