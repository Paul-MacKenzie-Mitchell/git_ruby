require 'pry'

DECK = { 'Spades': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                   {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': 11} ],
        'Clubs': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                  {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': 11} ],
        'Hearts': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                  {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': 11} ],
        'Diamonds': [ {'2': 2}, {'3': 3}, {'4': 4}, {'5': 5}, {'6': 6}, {'7': 7}, {'8': 8}, {'9': 9}, 
                  {'10': 10}, {'Jack': 10}, {'Queen': 10}, {'King': 10}, {'Ace': 11} ]
        }

HIT_OR_STAY = %w[HIT STAY H S]

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
  prompt(string)
  prompt("Your hand is worth #{hand_value(hand)} points.")
  prompt("YOU BUSTED!") if bust?(hand)
  puts ""
end

def display_dealer_hand(hand, ender = '.', punct = ', ', joiner = ' and ')
  unknown = "an unknown card"
  string = 'The dealers hand inludes '
  cards = convert_hand_to_string(hand)
  cards.each do |card|
    string += unknown if card == cards[0]
    string += joiner + card + ender if card == cards[-1]
    string += punct + card if card == cards[-2] &&
                               card != cards[0]
    string += punct + card if card != cards[-1] &&
                              card != cards[-2] &&
                              card != cards[0]
  end
  prompt(string)
  prompt("The dealer busted!") if bust?(hand)
  puts ""
end

def display_winner(p_hand, d_hand)
  winner = who_won?(p_hand, d_hand)
  prompt("You Won!") if winner == "Player"
  prompt("The Dealer Won...") if winner =="Dealer"
  prompt("It was a tie...") if winner == "Tie"
end
# =======================================
# Game Choice Methods
# =======================================

def deal_card_to_player?(deck, hand)
  answer = ''
  loop do
    prompt("Would you like to hit or stay?")
    loop do
      answer = gets.chomp.upcase
      break if HIT_OR_STAY.include?(answer)
      prompt("Please enter a valid answer...")
    end
    deal_one_card(deck, hand) if answer == "HIT" || answer == "H"
    break if answer == "STAY" || answer == "S"
    display_player_hand(hand)
    break if bust?(hand)
  end
  answer
end

def deal_card_to_dealer?(deck, d_hand, p_hand)
  loop do
    break if bust?(p_hand)
    break if hand_value(d_hand) >= 17
    deal_one_card(deck, d_hand)
  end
  display_dealer_hand(d_hand)
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
  system 'clear'
  prompt("The #{card[0].keys[0]} of #{card[1]} was dealt.")
end

# =======================================
# Hand Value Methods
# =======================================

def hand_value(hand)
  value = 0
  hand.each do |card|
    value += card[0].values[0]
  end
  return value if value <= 21
  value -= 10 if check_for_ace(hand)
  return value
end

def ace_values(hand)
  
end

def check_for_ace(hand)
  ace = 0
  hand.each do |card|
    ace += 1 if card[0] == {'Ace': 11}
  end
  return false if ace == 0
  return ace 
end


# =======================================
# Game Win Methods
# =======================================
def bust?(hand)
  return true if hand_value(hand) > 21
  false
end

def who_won?(p_hand, d_hand)
  return "Dealer" if bust?(p_hand)
  return "Player" if bust?(d_hand)
  return "Player" if hand_value(p_hand) > hand_value(d_hand)
  return "Dealer" if hand_value(d_hand) > hand_value(p_hand)
  return "Tie" if hand_value(d_hand) == hand_value(p_hand)
end

# =======================================
# Game Play
# =======================================

current_deck = initialize_deck
player_hand = initial_deal(current_deck)
dealer_hand = initial_deal(current_deck)
display_dealer_hand(dealer_hand)
display_player_hand(player_hand)
deal_card_to_player?(current_deck, player_hand)
deal_card_to_dealer?(current_deck, dealer_hand, player_hand)
display_winner(player_hand, dealer_hand)
puts "Done!"
