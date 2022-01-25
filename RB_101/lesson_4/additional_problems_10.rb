munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# munsters['Herman']['age_group'] = 'adult'

munsters.each do |key, value|
  if value['age'] < 18
    new_value = 'kid'
  elsif value['age'] < 65
    new_value = 'adult'
  else
    new_value = 'semior'
  end
  munsters[key]['age_group'] = new_value
end

p munsters