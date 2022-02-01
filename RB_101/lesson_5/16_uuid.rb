def uuid
  char_array = ('a'..'z').to_a + %w[0 1 2 3 4 5 6 7 8 9]
  string = ''
  string_lengths = [8, 4, 4, 4, 12]
  string_lengths.each do |num|
    counter = 0
    num.times do |char|
      string << char = char_array.sample
      counter += 1
      string << '-' if counter == num
    end
  end
  string.delete_suffix('-')
end

p uuid
