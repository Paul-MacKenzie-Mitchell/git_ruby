def prompt(message) #adds formatting
  puts "=> #{message}"
end

def test_num #Method to test if number is an integer 0..10
  test_array = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
  num = nil
  loop do
    prompt("Please enter an integer: ")
    num = gets.chomp
    if test_array.include?(num) == false
      prompt("Please enter a valid number")
    else
      num
      break
    end
  end
  num
end

def test_operator
  test_array = ['+', '-', '*', '/']
  op = nil
  loop do 
    prompt("Please enter an operation to perform ( +, -, *, /)")
    op = gets.chomp
    if test_array.include?(op) == false
      prompt("Please enter a valid operation")
    else
      return op
      break
    end
  end
end


prompt("Welcome to Calculator")

num_1 = nil
num_2 = nil
operation = nil

loop do 
  #ask the user for two numbers
  num_1 = test_num
  num_2 = test_num
  
  #perform the operation on the numbers
  
  #ask the user for an operation to perform
  operation = test_operator
  
  answer = case operation
            when '+'
              num_1.to_i + num_2.to_i
            when '-'
              num_1.to_i - num_2.to_i
            when '*'
              num_1.to_i * num_2.to_i
            when '/'
              while num_2 == '0'
                prompt("Cannot divide by 0, please enter a valid denominator")
                num_2 = gets.chomp
              end
              num_1.to_f / num_2.to_f
  end              
    
  #outut the results
  prompt("#{num_1} #{operation} #{num_2} is #{answer}")
  prompt("Enter 'Y' if you like to perform another calculation?")
  continue = gets.chomp.downcase
  if continue != 'y'
    prompt("Thank you for using the calcuator")
    break
  end
end