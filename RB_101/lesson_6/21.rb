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
# Game Display and Initialization Methods
# =======================================

def initialize_deck
  DECK.clone
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
  player_cards = []
  dealer_cards = []
  2.times do |card, suite| card, suite = select_card(deck)
    player_cards << suite
    player_cards << card
  end
  2.times do |card, suite| card, suite = select_card(deck)
    dealer_cards << suite
    dealer_cards << card
  end
  return player_cards, dealer_cards
end

def select_card(deck)
  card = []
  suite = deck.keys.sample
  deck[suite].each_with_index { |element, index| card << [element, index] }
  card = card.sample
  deck[suite].delete(card[0])
  return card[0], suite
end
  
def deal_one_card(deck)
  card = []
  card, suite = select_card(deck)
  card
end

# =======================================
# Game Win Methods
# =======================================
def bust?(hand)
  
end

# =======================================
# Game Play
# =======================================

current_deck = initialize_deck
player_hand, dealer_hand = initial_deal(current_deck)


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