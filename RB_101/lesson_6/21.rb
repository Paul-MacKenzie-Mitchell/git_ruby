require 'pry'

DECK = { 'Spades': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                   {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': [1,11]} ],
        'Clubs': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                  {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': [1,11]} ],
        'Hearts': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                  {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': [1,11]} ],
        'Diamonds': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                  {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': [1,11]} ]
        }

# =======================================
#  Initialization Methods
# =======================================

def initialize_deck
  DECK.clone
end

# =======================================
#  Display Methods
# =======================================

def prompt(message)
  puts "=> #{message}"
end

def convert_hand_to_string(hand)
  cards = []
  hand.each do |array| 
    cards << "the #{array[0].keys[0]} of #{array[1]}"
  end
  cards
end

def display_player_hand(hand, ender = '.', punct = ', ', joiner = ' and ')
  string = 'Your hand inludes '
  cards = convert_hand_to_string(hand)
  cards.each do |card|
    string += card + ender if card == cards[-1]
    string += card + joiner if card == cards[-2]
    string += card + punct if card != cards[-1] &&
                              card != cards[-2]
  end
  puts string
end

def display_dealer_hand(hand, ender = '.', punct = ', ', joiner = ' and ')
  string = 'The dealers hand inludes '
  cards = convert_hand_to_string(hand)
  cards.each do |card|
    string += "an unknown card" if card == cards[0]
    string += joiner + card + ender if card == cards[-1]
    string += punct + card if card == cards[-2] &&
                               card != cards[0]
    string += punct + card if card != cards[-1] &&
                              card != cards[-2] &&
                              card != cards[0]
  end
  puts string
end

# =======================================
# Game Choice Methods
# =======================================

def deal_card_to_player?(deck, hand)

end

def deal_card_to_dealer?(deck, d_hand, p_hand)
  
end

# =======================================
# Deal Methods
# =======================================

def initial_deal(deck)
  cards = []
  2.times do |card| card = select_card(deck)
    cards << card
  end
  cards
end

def select_card(deck)
  card = []
  suite = deck.keys.sample
  deck[suite].each { |element| card << [element] }
  card = card.sample
  deck[suite].delete(card[0])
  card = card[0], suite
end
  
def deal_one_card(deck, hand)
  card = select_card(deck)
  hand << card
end

# =======================================
# Hand Value Methods
# =======================================

def hand_value(hand)

# =======================================
# Game Win Methods
# =======================================
def bust?(hand)
  
end

# =======================================
# Game Play
# =======================================

current_deck = initialize_deck
player_hand = initial_deal(current_deck)
dealer_hand = initial_deal(current_deck)
display_player_hand(player_hand)
deal_one_card(current_deck, player_hand)





# p card = initial_deal(current_deck)

# p suite = current_deck.keys.sample
# current_deck[suite]
# card = []
# current_deck[suite].each_with_index do |element, index|
#   card << [element, index]  
# end
# p card = card.sample

# # current_deck.delete(current_deck[suite][card[1]])
# current_deck[suite].delete(card[0])
# p current_deck