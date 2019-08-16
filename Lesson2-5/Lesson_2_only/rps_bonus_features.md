  Let's upgrade to Rock-Paper-Scissors-Lizard-Spock game

Task 1: Add Lizard and Spock to the existing rock-paper-scissors gameplay

Task 2: Try to use one letter abbreviations for the 5 options
(what to do about the 2s (scissors & spock)

Task 3: Keep record of the score without modifying display_results
  method (One method performs a logical task, no more)
  Play until either the player or the computer reaches 5 wins (FT5)

-------------------------------------------------------------------------------
Task 1

Understanding the problem:
Add Lizard and Spock to the gameplay
  Updated rules
Rock: beats-lizard and scissors, loses_to-paper and spock
Paper: beats-rock and spock, loses_to-scissors and lizard
Scissors: beats-paper and lizard, loses_to-rock and spock
Lizard: beats-paper and spock, loses_to-rock and scissors
Spock: beats-rock and scissors, loses_to-paper and lizard

Examples:
Player's choice: LIZARD, Computer's choice: lizard => It's a tie.
Player's choice: Lizard, Computer's choice: Spock => Player won!
Player's choice: lizard, Computer's choice: RocK => Computer won!
Player's choice: Spock, Computer's choice: Scissors => Player won!
Player's choice: sPoCk, Computer's choice: SpOcK => It's a tie.
Player's choice: Paper, Computer's choice: Lizard => Computer won!

Data Structure:
Update my constant with the plus two options(lizard & spock)
First try adding all the 15-20 comparisons to see it working (done)
Then refactor it=>
Look up the player's move as a key in a hash, the value of that hash element
would be a list of moves that the player's move beats
Evaluate the result
Can I turn the if statement to a big case statement?

Algorithm:
Update the OPTIONS constant
Initialize a hash (e.g. winning_formula) that contains all 5 options as keys and
assign them to two options they beat, as values
Test winning_formula for the player and the computer to determine the winner
Check if first_choice(key) has the value of second choice(value)
If the key is not found in either cases, it's a tie
-------------------------------------------------------------------------------
Task 2

Understanding the problem:
Update options so that only initials are needed to be input ('rock' => 'r' etc.)
We have two options that start with 's', what to do with them

Examples:
('rock' => 'r', 'paper' => 'p', 'scissors' => 'sc', 'lizard' => 'l' and
'spock' => 'sp')

Data Structure:
(r-p-sc-l-sp) update values manually
Create two hashes; one for the choices and another for the winning combinations
User input is the updated abbreviation (e.g. 'r' for 'rock') but the output when
prompting who chose what, the full form shall be displayed.
Test code separately to determine the return value of each variable so that the
game does not fall apart.

Algorithm:
Update values manually
Change the value of VALID_CHOICES constant from array to a hash
Update the user and computer variables; the user input has to access the key of
the hash to see if the computer's choice is included among its values, the
computer's choice can be directly done from the values
-------------------------------------------------------------------------------
Task 3

Understanding the problem:
Keep score of the games
The game goes on until either the player or the computer gets to 5 wins

Examples:
wins? player
player 1, computer 0
wins? computer
player 1, computer 1 ... player 3, computer 5
Computer won the game.

Data Structure:
Create a break condition that sets the rule for the end of the game
Collect score in a variable, display it matching the current score and update it through the loop
Create a loop that makes the game go on until the break condition is met
Once broken out of the loop, display result and announce the winner
Ask the user about another game and validate user input for a new game

Algorithm:
Define a constant that holds a value that ends the game
Initialize a variable that keeps incrementing due to the score, while the loop
runs
It only increments player score or computer score if either wins a round.
Score is displayed after each incrementation
Tie is considered to be 0 and does not increment either score
Keep updating until either side reaches 5 wins
Break out of the loop when player score or computer score equals the constant
we defined to end the game
Display the final score and the winner of the game (string interpolations)
Prompt the user about new_game?
If the user gives an answer from a set of possible answers, the game is either
over, or a new one begins. Otherwise input is invalid.
