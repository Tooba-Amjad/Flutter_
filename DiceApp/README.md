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
![1](https://github.com/user-attachments/assets/78a9cefd-5799-4e55-9082-fcf801a762cc)
![2](https://github.com/user-attachments/assets/6c6f3f2a-20bd-4d92-9823-fab37464c4b3)


YouTube Video




https://github.com/user-attachments/assets/40a5148d-9e95-4ad6-99e1-808d9541bc0d






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




