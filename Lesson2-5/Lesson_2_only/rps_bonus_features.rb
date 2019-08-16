VALID_CHOICES = {
  r: 'rock',
  p: 'paper',
  sc: 'scissors',
  l: 'lizard',
  sp: 'spock'
}

WINNING_FORMULA = {
  'rock' => %w(lizard scissors),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(rock scissors)
}

MAKE_YOUR_CHOICE = <<-MSG
Choose one of the options from below!
'r' for rock
'p' for paper
'sc' for scissors
'l' for lizard
'sp' for spock
MSG

NUMBER_TO_WIN = 5

POSITIVE_ANSWER = %w(y yes yeah sure)

NEGATIVE_ANSWER = %w(n no nope negative)

def prompt(message)
  Kernel.puts "=> #{message}"
end

def obtain_player_choice
  choice = ''
  loop do
    prompt(MAKE_YOUR_CHOICE)
    choice = Kernel.gets().chomp().downcase
    if VALID_CHOICES.include?(choice.intern)
      return choice = VALID_CHOICES[choice.intern]
    else
      prompt("That's not a valid choice to make, try again.")
    end
  end
end

def wins?(first, second)
  WINNING_FORMULA[first].include?(second)
end

def display_results(player, computer)
  if wins?(player, computer)
    prompt("You won the round!")
  elsif wins?(computer, player)
    prompt("Computer won the round!")
  else
    prompt("It's a tie.")
  end
end

def end_of_the_game?(first, second)
  first == NUMBER_TO_WIN || second == NUMBER_TO_WIN
end

def game_winner(score1, score2)
  if score1 > score2
    "Player"
  else
    "Computer"
  end
end

def play_again?
  answer = ''
  loop do
    prompt("Do you wanna play again?")
    answer = Kernel.gets().chomp().downcase
    if POSITIVE_ANSWER.include?(answer)
      return true
    elsif NEGATIVE_ANSWER.include?(answer)
      return false
    else
      prompt("That is an invalid answer!")
    end
  end
end

prompt("Welcome to the magical rock-paper-scissors-lizard-spock game!")

prompt("-------------------------------------------------------------")

loop do
  round_count = 0
  player_score = 0
  computer_score = 0

  loop do
    prompt("Round #{round_count + 1}, fight!")
    player_choice = obtain_player_choice
    computer_choice = VALID_CHOICES.values.sample

    prompt("You chose #{player_choice}, the computer chose #{computer_choice}.")

    display_results(player_choice, computer_choice)

    if wins?(player_choice, computer_choice)
      player_score += 1
    elsif wins?(computer_choice, player_choice)
      computer_score += 1
    else
      prompt("The score is not going to change.")
    end

    round_count += 1
    prompt("Score: player-computer #{player_score} - #{computer_score}.")
    break if end_of_the_game?(player_score, computer_score)
  end

  prompt("The grand champion is: #{game_winner(player_score, computer_score)}!")

  break unless play_again?
end

prompt("Thank you for playing!")
