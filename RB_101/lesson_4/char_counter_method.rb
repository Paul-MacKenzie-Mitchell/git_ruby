def character_counter(string, char)
  char_counter = 0
  output_string = ''
  loop do
    break if string.length == char_counter
    if string[char_counter] == char
      output_string << char
    end
    char_counter += 1
  end
  output_string
end
  
question = 'How many times does a particular character appear in this sentence?'

p character_counter(question, 'd')
