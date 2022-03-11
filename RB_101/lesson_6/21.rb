require 'pry'
require 'yaml'

MESSAGES = YAML.load_file('21_messages.yml')
DECK = { 'Spades': [{ '2': 2 }, { '3': 3 }, { '4': 4 }, { '5': 5 },
                    { '6': 6 }, { '7': 7 }, { '8': 8 }, { '9': 9 },
                    { '10': 10 }, { 'Jack': 10 }, { 'Queen': 10 },
                    { 'King': 10 }, { 'Ace': 11 }],
         'Clubs': [{ '2': 2 }, { '3': 3 }, { '4': 4 }, { '5': 5 },
                   { '6': 6 }, { '7': 7 }, { '8': 8 }, { '9': 9 },
                   { '10': 10 }, { 'Jack': 10 }, { 'Queen': 10 },
                   { 'King': 10 }, { 'Ace': 11 }],
         'Hearts': [{ '2': 2 }, { '3': 3 }, { '4': 4 }, { '5': 5 },
                    { '6': 6 }, { '7': 7 }, { '8': 8 }, { '9': 9 },
                    { '10': 10 }, { 'Jack': 10 }, { 'Queen': 10 },
                    { 'King': 10 }, { 'Ace': 11 }],
         'Diamonds': [{ '2': 2 }, { '3': 3 }, { '4': 4 }, { '5': 5 },
                      { '6': 6 }, { '7': 7 }, { '8': 8 }, { '9': 9 },
                      { '10': 10 }, { 'Jack': 10 }, { 'Queen': 10 },
                      { 'King': 10 }, { 'Ace': 11 }] }
MAX_PLAYABLE_VALUE = 21
DEALER_LIMIT = 17
CHOICE = %w(HIT STAY H S)
HIT = %w(HIT H)
STAY = %w(STAY S)

# =======================================
#  Initialization Methods
# =======================================

def initialize_deck
  system 'clear'
  Marshal.load(Marshal.dump(DECK))
end

# =======================================
#  Display Methods
# =======================================

def prompt(message)
  puts "=> #{message}"
end

def welcome
  puts "            <-<-<->->->     #{MESSAGES['welcome']}     <-<-<->->->"
  puts ""
  puts ""
  prompt("If you would like to learn the rules of the game type 'rules'")
  prompt("Otherwise hit any key to continue")
  rules
end

def hit_any_key_to_continue
  prompt("Hit any key to continue")
  gets.chomp
end

def rules
  choice = gets.chomp.downcase
  if choice == 'rules' || choice == 'r'
    puts MESSAGES['rules']
    sleep 2.5
    puts ""
    hit_any_key_to_continue
  end
  system 'clear'
  prompt("The first player to win 5 games takes the match!")
  sleep 1
end

def convert_hand_to_string(hand)
  cards = []
  hand.each do |array|
    cards << "the #{array[0].keys[0]} of #{array[1]}"
  end
  cards
end

def display_player_hand(hand)
  string = 'Your hand inludes '
  cards = convert_hand_to_string(hand)
  cards.each do |card|
    string += if card == cards[-1]
                card + '.'
              elsif card == cards[-2]
                card + ' and '
              else
                card + ', '
              end
  end
  prompt(string)
  prompt("Your hand is worth #{hand_value(hand)} points.")
  prompt("YOU BUSTED!") if bust?(hand)
  puts ""
end

def format_display_dealer_hand(hand, hide_card)
  string = 'The dealers hand inludes '
  cards = convert_hand_to_string(hand)
  variable = "the hole card" if hide_card
  variable = cards[0] if !hide_card
  cards.each do |card|
    string += if card == cards[0]
                variable
              elsif card == cards[-1]
                ' and ' + card + '.'
              else
                ', ' + card
              end
  end
  display_dealer_hand(hand, hide_card, string)
end

def display_dealer_hand(hand, hide_card, string)
  prompt(string)
  prompt(MESSAGES['dealer'] + "#{hand_value(hand)} points.") if !hide_card
  prompt("The dealer busted!") if bust?(hand)
  puts ""
end

def display_winner(winner)
  prompt("You Won!") if winner == "Player"
  prompt("The Dealer Won...") if winner == "Dealer"
  prompt("It was a tie...") if winner == "Tie"
end

def score(player, dealer, draw)
  puts ""
  puts "         Match Score"
  puts '==========================='
  puts " Player | Dealer | Ties "
  puts "========+=================="
  puts "   #{player}    |    #{dealer}  |   #{draw}"
  puts ""
  hit_any_key_to_continue
  system 'clear'
end
# =======================================
# Game Choice Methods
# =======================================

def ask_to_deal_card(answer)
  prompt("Would you like to hit or stay?")
  loop do
    answer = gets.chomp.upcase
    break if HIT.include?(answer) || STAY.include?(answer)
    prompt("Please enter a valid answer...")
  end
  answer
end

def deal_card_to_player?(deck, hand)
  answer = ''
  loop do
    answer = ask_to_deal_card(answer)
    deal_one_card(deck, hand) if HIT.include?(answer)
    display_player_hand(hand)
    chose_to_stay if STAY.include?(answer)
    break if STAY.include?(answer) || bust?(hand)
  end
end

def deal_card_to_dealer?(deck, d_hand, p_hand, hide_card)
  loop do
    break if bust?(p_hand)
    prompt("The Dealer stays") if  hand_value(d_hand) >= DEALER_LIMIT
    break if hand_value(d_hand) >= DEALER_LIMIT
    deal_one_card(deck, d_hand)
  end
  format_display_dealer_hand(d_hand, hide_card)
end

def chose_to_stay
  system 'clear'
  prompt("You chose to stay...it is now the dealers turn")
  sleep 1.5
end

def play_again?
  valid = ['Y', 'y', 'Yes', 'YES', 'yes']
  prompt("Would you like to play again? Y or N")
  play_again = gets.chomp
  valid.any?(play_again)
end

# =======================================
# Deal Methods
# =======================================

def initial_deal(deck)
  cards = []
  2.times do
    card = select_card(deck)
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
  return value if value <= MAX_PLAYABLE_VALUE
  value -= 10 if check_for_ace(hand)
  value
end

def ace_values(hand); end

def check_for_ace(hand)
  ace = 0
  hand.each do |card|
    ace += 1 if card[0] == { 'Ace': 11 }
  end
  return false if ace == 0
  ace
end

# =======================================
# Game Win Methods
# =======================================

def bust?(hand)
  return true if hand_value(hand) > MAX_PLAYABLE_VALUE
  false
end

def who_won?(p_hand, d_hand)
  return "Dealer" if bust?(p_hand)
  return "Player" if bust?(d_hand)
  return "Player" if hand_value(p_hand) > hand_value(d_hand)
  return "Dealer" if hand_value(d_hand) > hand_value(p_hand)
  return "Tie" if hand_value(d_hand) == hand_value(p_hand)
end

def add_win_count(winner, p_win, d_win, draw)
  if winner == "Player"
    p_win += 1
  elsif winner == "Dealer"
    d_win += 1
  else
    draw += 1
  end
  return p_win, d_win, draw
end

# =======================================
# Game Play Methods
# =======================================

def round(current_deck)
  hide_card = true
  # current_deck = initialize_deck
  player_hand = initial_deal(current_deck)
  dealer_hand = initial_deal(current_deck)
  format_display_dealer_hand(dealer_hand, hide_card)
  display_player_hand(player_hand)
  deal_card_to_player?(current_deck, player_hand)
  hide_card = false
  deal_card_to_dealer?(current_deck, dealer_hand, player_hand, hide_card)
  round_winner = who_won?(player_hand, dealer_hand)
  display_winner(round_winner)
  round_winner
end

# =======================================
# Game Play
# =======================================

welcome
loop do
  player_win = 0
  dealer_win = 0
  tie = 0
  loop do
    current_deck = initialize_deck
    round_winner = round(current_deck)
    player_win, dealer_win, tie = add_win_count(round_winner,
                                                player_win,
                                                dealer_win,
                                                tie)
    score(player_win, dealer_win, tie)
    if player_win == 5
      prompt("YOU WON THE MATCH!!!")
      break
    elsif dealer_win == 5
      prompt("You lost the match...so sad :(")
      break
    end
  end
  break if !play_again?
end
prompt("Thanks for playing")
