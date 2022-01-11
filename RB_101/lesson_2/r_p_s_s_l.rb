COUNT_TO_WIN = 3
VALID_CHOICES = { 'rock' => 'r',
                  'paper' => 'p',
                  'scissors' => 's',
                  'spock' => 'sp',
                  'lizard' => 'l'
}

WIN_CONDITIONS = {  'rock' => %w[scissors lizard s l],
                    'r' => %w[scissors lizard s l],
                    'paper' => %w[rock spock r sp],
                    'p' => %w[rock spock r sp],
                    'scissors' => %w[paper lizard p l],
                    's' =>  %w[paper lizard p l],
                    'spock' => %w[rock scissors r s],
                    'sp' => %w[rock scissors r s],
                    'lizard' => %w[spock paper sp p],
                    'l' => %w[spock paper sp p]
}

#conditional methods
def answer_to_yes_or_no
  answer = gets.chomp.downcase
  continue_with_request = %w[y yes]
  continue_with_request.include?(answer)
end

def win?(player1, player2)
  WIN_CONDITIONS[player1.to_s][0] == player2 || 
  WIN_CONDITIONS[player1.to_s][1] == player2 ||
  WIN_CONDITIONS[player1.to_s][2] == player2 ||
  WIN_CONDITIONS[player1.to_s][3] == player2 
end

#display methods

def prompt(message)
  puts "\n => #{message}"
end

def display_unabreviated_input(input)
  if VALID_CHOICES.has_key?(input)
    input
  else
    display = case input
              when 'r'
                'rock'
              when 's'
                'scissors'
              when 'p'
                'paper'
              when 'sp'
                'spock'
              when 'l'
                'lizard'
              end
              display
  end
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

def display_tie_or_ties(num)
  if num != 1
    'ties'
  else
    'tie'
  end
end

def display_number_of_wins(wins, losses, ties)
  prompt("Your score is
  #{wins} #{display_win_or_wins?(wins)} 
  #{losses} #{display_loss_or_losses?(losses)}")
  if ties != 0
    puts("  #{ties} #{display_tie_or_ties(ties)}")
  end
end



# Formatted messages
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

#begin program

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
  tie_count = 0
  #loops round
  loop do 
    choice = ''
    #loops choice
    loop do 
      prompt("Round #{round}!")
      prompt("Choose either #{VALID_CHOICES.keys.join(', ')} (#{VALID_CHOICES.values.join(', ')})")
      
      choice = gets.downcase.chomp
      system "clear"
      if VALID_CHOICES.include?(choice)
        break
      elsif VALID_CHOICES.has_value?(choice)
        break
      else
        prompt('That was not a valid choice')
      end
    end

    computer_choice = VALID_CHOICES.keys.sample.to_s
    puts computer_choice
    prompt("You chose #{display_unabreviated_input(choice)} the computer chose #{display_unabreviated_input(computer_choice)}")
    display_results(choice, computer_choice, round)
    
    round += 1
    if win?(choice, computer_choice)
      player_win_count += 1 
    elsif win?(computer_choice, choice)
      computer_win_count += 1 
    else 
      tie_count += 1
    end
    display_number_of_wins(player_win_count, computer_win_count, tie_count)
    

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
