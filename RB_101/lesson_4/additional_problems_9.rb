def titelize(string)
# input =  a string
#iterate over each character in the string
  char_array = string.chars
  new_string = ''
  char_array.each_with_index do |char, index|
    if index == 0
      new_string << char.upcase 
    elsif string[index - 1] == ' '
      new_string << char.upcase 
    else
    new_string << char
    end
    
#if it is the first character if the string and not a space capitalize it
#elsif it is the first character after a space capitlize it 
#else leave character as is
#push character to new string
#return new string
  end
# output =  a new string
  new_string
end

original_string =  "the flintstones rock"
p titelize(original_string)

words = "the flintstones rock"
p words.split.map { |word| word.capitalize }.join(' ')