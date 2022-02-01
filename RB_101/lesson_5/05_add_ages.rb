munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.map do |person|
  puts person[1]
end

munsters.map do |person|
  puts person[0]
end

total_male_ages = 0
munsters.map do |person|
  if person[1]["gender"] == "male"
    total_male_ages += person[1]["age"]
  end
end

p total_male_ages 

total_male_ages = 0
munsters.each_value do |details|
  if details['gender'] == 'male'
    total_male_ages += details["age"]
  end
end

p total_male_ages