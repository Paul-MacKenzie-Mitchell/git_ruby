hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

VOWELS = 'aeiou'
vowels = []
hsh.each_pair do |key, value|
  value.map do |word|
    word.each_char do |char|
      vowels << char if VOWELS.include?(char)
    end
  end
end

p vowels.join

hsh.each do|key, value|
  value.each do |string|
    string.each_char do |char|
      puts char if VOWELS.include?(char)
    end
  end
end
