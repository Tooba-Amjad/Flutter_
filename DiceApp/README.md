# Flutter Dice Game

This is a simple dice game developed using Flutter. The game allows up to four players to roll dice and accumulate points, with special rules for when a player rolls a six.

## Features

- **Multi-player Support**: Play with up to 4 players.
- **Rolling Dice**: Tap the dice image to roll and get a random value.
- **Score Tracking**: Keep track of each player's score.
- **Win Condition**: Set a target score to determine the winner.
- **Dice Size Change**: Dice appear larger when a player rolls a six.
- **Turn Skipping**: If a player rolls a six, the next player's turn is skipped.



# Game Logic

## Overview
The game features multiple players who take turns rolling dice. When a player rolls a six, they have to pass the turn to the next player. The game continues until one player reaches the predefined target score.

## Implementation Details
The main components of the game include:

- **State Management**: The game state is managed using a `StatefulWidget`.
- **Random Number Generation**: The dice values are generated randomly using `Random().nextInt(6) + 1`.
- **Score Calculation**: Players' scores are updated based on the dice roll.
- **User Interface**: The UI is built using Flutter's Widget tree, including `Scaffold`, `ListView`, and `AlertDialog` for displaying the winner.

## Key Classes
- **DiceApp**: The root widget of the application.
- **DiceWithStateful**: The main game widget that handles game logic and UI.
- **_DiceWithStatefulState**: The state class that manages player turns, scores, and dice rolling.

## Usage
1. Start the game by tapping the "Play Game" button.
2. Enter the target score.
3. Roll the dice by tapping on them.
4. The game continues until a player reaches the target score.

## Images
Here are the images used in the game:
![Spin the Bottle Image 1](1.png)
![Spin the Bottle Image 2](2.png)



YouTube Video


https://github.com/user-attachments/assets/06c23b5e-eb5c-401d-bdf8-480cdfcd289e




## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dice-game.git
2. Navigate to the project directory:
   ```bash
   cd dice-game
3-Install the necessary dependencies:
   ```bash
   flutter run



