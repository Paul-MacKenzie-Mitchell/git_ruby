def select_fruit(produce_list)
  produce_keys = produce_list.keys
  counter = 0
  selected_fruits = {}
  loop do
    break if counter == produce_list.length
    current_produce = produce_keys[counter]
    if produce_list[current_produce] == 'Fruit'
      selected_fruits[current_produce] ='Fruit'
    end
    counter += 1
  end
  selected_fruits
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable',
  'mango' => "Fruit"
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}