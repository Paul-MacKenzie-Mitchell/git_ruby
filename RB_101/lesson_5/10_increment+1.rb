array = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

new_array =[]

new_array = array.map do |hash|
  hash.each_pair do |key, value|
    hash[key] = value + 1
  end
end

p new_array
  
new_array2 = array.map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end

p new_array2