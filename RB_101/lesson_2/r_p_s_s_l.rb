COUNT_TO_WIN = 3
VALID_CHOICES = %w[rock paper scissors spock lizard]
WIN_CONDITIONS = {  'rock' => %w[scissors lizard],
                    'paper' => %w[rock spock],
                    'scissors' => %w[paper lizard],
                    'spock' => %w[rock scissors],
                    'lizard' => %w[spock paper]
}

def prompt(message)
  puts "\n => #{message}"
end

def answer_to_yes_or_no
  answer = gets.chomp.downcase
  continue_with_request = %w[y yes]
  continue_with_request.include?(answer)
end

def win?(player1, player2)
  WIN_CONDITIONS[player1.to_s][0] == player2 || 
  WIN_CONDITIONS[player1.to_s][1] == player2
end

def display_results(player, computer, round)
  if win?(player, computer)
    prompt("You won round #{round}!")
  elsif win?(computer, player)
    prompt("You lost round #{round}!")
  else
    prompt("You tied round #{round}")
  end
end

def display_win_or_wins?(num)
  if num != 1
    'wins'
  else
    'win'
  end
end

def display_loss_or_losses?(num)
  if num != 1
    'losses'
  else
    'loss'
  end
end

def display_number_of_wins(wins, losses)
  prompt("You have #{wins} #{display_win_or_wins?(wins)} and #{losses} #{display_loss_or_losses?(losses)}")
end

rules = <<-MSG
      Scissors cuts paper, 
          paper covers rock, 
          rock crushes lizard, 
          lizard poisons Spock, 
          Spock smashes scissors, 
          scissors decapitates lizard, 
          lizard eats paper, 
          paper disproves Spock, 
          Spock vaporizes rock, 
          and as it always has, rock crushes scissors.
    MSG

start_message = <<~MSG
  Welcome to 'Rock, Paper, Scissors, Spock, Lizard
  #{'  '}

  #{'  '}
          First to #{COUNT_TO_WIN} wins!
  #{'  '}
MSG

prompt(start_message)
prompt("Would you like to see the rules? (Y or N)")

if answer_to_yes_or_no
  system "clear"
  prompt(rules)
  prompt("Hit any key to continue")
  any_key = gets.chomp
  system "clear" if any_key
end

#loops entire game
loop do
  round = 1
  player_win_count = 0
  computer_win_count = 0
  #loops round
  loop do 
    choice = ''
    #loops choice
    loop do 
      prompt("Round #{round}!")
      #prompt("Choose either #{VALID_CHOICES.join(', ')}")
      choice = gets.downcase.chomp
      system "clear"
      break if VALID_CHOICES.include?(choice)
      prompt('That was not a valid choice')
    end

    computer_choice = VALID_CHOICES.sample
    prompt("You chose #{choice} the computer chose #{computer_choice}")
    display_results(choice, computer_choice, round)
    
    round += 1
    player_win_count += 1 if win?(choice, computer_choice)
    computer_win_count += 1 if win?(computer_choice, choice)
    display_number_of_wins(player_win_count, computer_win_count)
    

    if player_win_count == COUNT_TO_WIN
      prompt('You won the match! :)')
      break
    elsif computer_win_count == COUNT_TO_WIN
      prompt('You lost the match... :(')
      break
    end
  end
  
  
  prompt('Would you like to play again? (Y or N)')
  break unless answer_to_yes_or_no
  system "clear"
end 
prompt('Thanks for playing.  Goodbye!')
