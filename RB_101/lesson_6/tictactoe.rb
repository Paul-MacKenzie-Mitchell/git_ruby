# Constants
WINNING_CONDITION = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                    [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                    [[1, 5, 9], [3, 5, 7]]

# Message and communication methods
def start(message)
  puts "            <-<-<->->->     #{message}     <-<-<->->->"
  puts ""
  puts ""
  prompt("If you would like to learn the rules of the game type 'rules', otherwise hit any key")
  rules
  puts ""
  prompt("Hit any key to continue")
  gets.chomp
end

def rules
  choice = gets.chomp.downcase
  if choice == 'rules' || choice == 'r'
    puts ''
    puts "- The game is played on a grid that's 3 squares by 3 squares."
    puts "- Choose either X or O as your piece, your friend (or the computer in this case) is the other piece." 
    puts "- Players take turns putting their marks in empty squares."
    puts "- The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner."
    puts "- When all 9 squares are full, the game is over."
    sleep 2.5
  end
end

def prompt(message)
  puts "=> #{message}"
end

def joinor(valid, punctuation = ', ', word = ' or ')
  string = ''
  valid.each do |element|
    case element
    when element == valid[-1]
      string += element.to_s
    when element == valid[-2]
      string += element.to_s + word
    else
      string += element.to_s + punctuation
    end
  end
  string
end

# Board Display methods
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

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = num.to_s }
  board
end

# Choice Methods
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

# Play Methods
def player_makes_choice!(brd, piece, valid)
  square = ''
  loop do
    prompt("Choose an open square #{joinor(valid)}")
    square = gets.chomp.to_i
    break if valid.include?(square)
    prompt("Please choose a valid option")
  end
  valid.delete(square)
  brd[square] = piece
end

def computer_makes_choice!(brd, piece, valid)
  square = valid.sample
  valid.delete(square)
  brd[square] = piece
end

# Determine Winner Methods
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

# Game Start
start("Welcome to Tic Tac Toe")
loop do
  system 'clear'
  board = initialize_board
  valid_squares = board.keys
  player_piece, computer_piece = choose_x_or_o
  # computer_piece = computer_x_or_o(player_piece)
  loop do
    system 'clear'
    display_board(board)
    player_makes_choice!(board, player_piece, valid_squares)
    break if win?(board, player_piece, computer_piece) || valid_squares.empty?
    computer_makes_choice!(board, computer_piece, valid_squares)
    break if win?(board, player_piece, computer_piece) || valid_squares.empty?
  end
  display_board(board)
  if win?(board, player_piece, computer_piece)
    prompt(who_one(board, player_piece, computer_piece).to_s)
  else
    prompt("It was a tie...")
  end
  break if play_again?
end
prompt("Thanks for playing Tic Tac Toe")