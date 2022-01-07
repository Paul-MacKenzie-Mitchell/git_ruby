def prompt(message)
  puts "=> #{message}"
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def input_valid?(input)
  loop do
    input = gets.chomp
    if valid_number?(input)
      break
    else
      prompt('Please enter a valid number')
    end
  end
  input.to_f
end

def use_float(num)
  if integer?(num)
    num.to_i
  else
    num.to_f
  end
end


prompt('Welcome to the interest calculator')
prompt('Please enter a user name')
name = ' '
loop do
  name = gets.chomp
  if name.empty?
    prompt('Please enter a valid user name')
  else
    break
  end
end
# input for loan amount
loop do
  # input for loan amount
  prompt('Enter the amount of the loan') 
  loan_amount = input_valid?(loan_amount)
  # input for APR
  prompt('Enter the APR of the loan')
  annual_percentage_rate = input_valid?(annual_percentage_rate)
  annual_percentage_rate = annual_percentage_rate.to_f / 100
  #input for loan length
  prompt('Enter the number of months the loan will be payed in')
  months = input_valid?(months)
  #calculate
  monthly_interest_rate = annual_percentage_rate / 12
  if months != 0.0
    monthly_payment = loan_amount * (monthly_interest_rate/(1 - (1 + monthly_interest_rate)**(-months)))
  else
    monthly_payment = loan_amount
  end
  
  if months != 0.0
    total_interest = (monthly_payment * months) - loan_amount
  else
    total_interest = 0.0
  end
  
  #output
  if months == 0.0
    prompt("#{name}, your monthly payments for your loan of $#{'%.2f' % loan_amount} will be $#{'%.2f' % monthly_payment} paid immediately")
    prompt("The total interest you will pay is $#{'%.2f' % total_interest}")
  else
    prompt("#{name}, your monthly payments for your loan of $#{'%.2f' % loan_amount} will be $#{'%.2f' % monthly_payment} for #{months.to_i.to_s} months")
    prompt("The total interest you will pay is $#{'%.2f' % total_interest}")
  end
  #calculate again?
  prompt "Would You like to calculate another loan #{name}?  Enter Y to continue"
  continue = gets.chomp
  if continue.downcase != 'y'
    break
  end
end
