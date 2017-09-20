# mastermind
my first project in Swift: an interactive version of the popular game Mastermind

The objective is to figure out the randomly generated code in 8 or fewer tries by submitting iterative guesses.
There are two types of feedback: a black dot, and a white dot. A black dot signifies a correct color in the correct index, and a white dot signifies a correct color that is not in the correct index. 
No information regarding which color or which index is correct.

Guesses are constructed by tapping the 4 buttons at the bottom of the screen which cylce through the 6 available colors. A preview is simultaneously displayed at the corresponding guess index above. To submit a guess, the user swipes to the right over the 4 buttons. 

The game ends when either
  1. the user guesses the correct code
  2. the user runs out of guesses
in both cases the correct code is displayed to the user.

A menu button exists at the top-right of the screen with the option to clear the board and start a new game. This function also generates a new code.

Future functionality:
  - high score tracking
  - sound effects
  - difficulty settings (adjusts the number of colors or guesses available)
