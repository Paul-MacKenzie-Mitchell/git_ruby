
def prompt(message)
  puts "=> #{message}"
end

# Method to test if number is an integer 0..10
def test_num
  test_array = %w[0 1 2 3 4 5 6 7 8 9]
  num = nil
  loop do
    prompt('Please enter an integer: ')
    num = gets.chomp
    break unless test_array.include?(num) == false

    prompt('That was not a valid number')
  end
  num
end

def test_operator
  test_array = ['+', '-', '*', '/']
  op = nil
  loop do
    prompt('Please enter an operation to perform ( +, -, *, /)')
    op = gets.chomp
    if test_array.include?(op) == false
      prompt('Please enter a valid operation')
    else
      return op
    end
  end
end

prompt('Welcome to Calculator')

num1 = nil
num2 = nil
operation = nil

loop do
  # ask the user for two numbers
  num1 = test_num
  num2 = test_num

  # perform the operation on the numbers

  # ask the user for an operation to perform
  operation = test_operator

  answer = case operation
           when '+'
             num1.to_i + num2.to_i
           when '-'
             num1.to_i - num2.to_i
           when '*'
             num1.to_i * num2.to_i
           when '/'
             while num2 == '0'
               prompt('Cannot divide by 0, please enter a valid denominator')
               num2 = gets.chomp
               num2 = test_num
             end
             num1.to_i / num2.to_f
           end

  # outut the results
  prompt("#{num1} #{operation} #{num2} is #{answer}")
  prompt("Enter 'Y' if you like to perform another calculation?")
  continue = gets.chomp.downcase
  if continue != 'y'
    prompt('Thank you for using the calcuator')
    break
  end
end
