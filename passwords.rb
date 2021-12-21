puts "HI"
Password = 'Jesusfuckingchrist'
Username = "Paul"
loop do
  puts "Please enter your user name"
  input_name = gets.chomp
  puts "Please enter you password"
  input_password = gets.chomp
  break if input_name == Username && input_password == Password
  puts "Authentication denied!"
end
puts "Welcome"