require 'yaml'
require 'pry'
# =============================================
# Constants
# =============================================
MESSAGES = YAML.load_file('tictactoe_messages.yml')
WINNING_CONDITION = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                    [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                    [[1, 5, 9], [3, 5, 7]]

BOARD = [1, 2, 3, 4, 5, 6, 7, 8, 9]
# =============================================
# Message and communication methods
# =============================================
def start(message)
  puts "            <-<-<->->->     #{message}     <-<-<->->->"
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
  prompt("The first player to win 5 games takes the match!")
  sleep 1
end

def prompt(message)
  puts "=> #{message}"
end

def joinor(valid, punctuation = ', ', word = ' or ')
  string = ''
  valid.each do |element|
    string += element.to_s if element == valid[-1]
    string += element.to_s + word if element == valid[-2]
    string += element.to_s + punctuation if element != valid[-1] &&
                                            element != valid[-2]
  end
  string
end

def score(player, comp, draw)
  puts ""
  puts "         Match Score"
  puts '==========================='
  puts " Player | Computer | Ties "
  puts "========+==========+======="
  puts "   #{player}    |     #{comp}    |   #{draw}"
  puts ""
  hit_any_key_to_continue
  BOARD.clone
end

# =============================================
# Board Display methods
# =============================================
def initialize_board
  board = {}
  (1..9).each { |num| board[num] = num.to_s }
  board
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end
# rubocop:enable Metrics/AbcSize

# =============================================
# Choice Methods
# =============================================

def choose_x_or_o
  piece = '', computer_piece = ''
  loop do
    prompt("Choose either X or O as your piece")
    piece = gets.chomp.upcase
    if piece == 'X'
      computer_piece = 'O'
      break
    elsif piece == 'O'
      computer_piece = 'X'
      break
    else
      prompt("Please choose a valid option")
    end
  end
  return piece, computer_piece
end

def play_again?
  valid = ['Y', 'y', 'Yes', 'YES', 'yes']
  prompt("Would you like to play again? Y or N")
  play_again = gets.chomp
  valid.none?(play_again)
end

# =============================================
# Play Methods
# =============================================
def player_makes_choice!(brd, piece, valid)
  square = ''
  loop do
    prompt("Choose an open square: #{joinor(valid)}")
    square = gets.chomp.to_i
    break if valid.include?(square)
    prompt("Please choose a valid option")
  end
  valid.delete(square)
  brd[square] = piece
end

def computer_makes_choice!(brd, c_piece, p_piece, valid)
  square = nil
  square = 5 if valid.include?(5)
  if find_at_risk_square(brd, c_piece, valid)
    square = find_at_risk_square(brd, c_piece, valid)[0]
  end
  if square.nil? && find_at_risk_square(brd, p_piece, valid)
    square = find_at_risk_square(brd, p_piece, valid)[0]
  end
  square = valid.sample if square.nil?
  valid.delete(square)
  brd[square] = c_piece
end

def find_at_risk_square(brd, piece, valid)
  square = nil
  WINNING_CONDITION.each do |line|
    if brd.values_at(*line).count(piece) == 2
      square = valid.select { |num| line.include?(num) }
    end
  end
  square
end

# =============================================
# Determine Winner Methods
# =============================================

def win?(brd, player_piece, computer_piece)
  !!who_one(brd, player_piece, computer_piece)
end

def who_one(brd, piece1, piece2)
  WINNING_CONDITION.each do |line|
    if brd.values_at(*line).count(piece1) == 3
      return "Player Won!"
    elsif brd.values_at(*line).count(piece2) == 3
      return "The Computer Won :("
    end
  end
  nil
end

def assign_win(brd, piece1, piece2, player_wins, computer_wins)
  if who_one(brd, piece1, piece2) == "Player Won!"
    player_wins += 1
  else
    computer_wins += 1
  end
  return player_wins, computer_wins
end

def game_winner(player_wins, computer_wins)
  result = nil
  if player_wins >= 5
    prompt("YOU WON THE MATCH !!! ")
    result = !!player_wins
  elsif computer_wins >= 5
    prompt("The computer won...so sad :(")
    result = !!computer_wins
  end
  result
end

# =============================================
# Game Start
# =============================================
start("Welcome to Tic Tac Toe")
# =============================================
# game best of 5
# =============================================
loop do
  player_wins = 0
  computer_wins = 0
  tie = 0
  player_piece, computer_piece = choose_x_or_o
  # =============================================
  # round
  # =============================================
  loop do
    system 'clear'
    board = initialize_board
    valid_squares = BOARD.clone
    loop do
      display_board(board)
      player_makes_choice!(board, player_piece, valid_squares)
      break if win?(board, player_piece, computer_piece) || valid_squares.empty?
      computer_makes_choice!(board, computer_piece, player_piece, valid_squares)
      break if win?(board, player_piece, computer_piece) || valid_squares.empty?
    end
    display_board(board)
    if win?(board, player_piece, computer_piece)
      player_wins, computer_wins = assign_win(board, player_piece,
                                              computer_piece, player_wins,
                                              computer_wins)
      prompt(who_one(board, player_piece, computer_piece))
    else
      prompt("It was a tie...")
      tie += 1
    end
    valid_squares = score(player_wins, computer_wins, tie)
    break if game_winner(player_wins, computer_wins)
  end
  break if play_again?
end
prompt("Thanks for playing Tic Tac Toe")
