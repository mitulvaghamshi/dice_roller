# Dice Roller

A casual, interactive, single user, dice rolling game.

### Original (dice_game.py)

[dice_game.py](assets/files/dice_game.py)

### [Game control flow]

[game-flow.pdf](assets/files/game-flow.pdf)

```
|--------------------------------------------------------------------------------------------------------------|
|---------------------------------------Welcome to Dice Game, Good Luck!---------------------------------------|
|--------------------------------------------------------------------------------------------------------------|
The game is based on 5 winning criteria..., match any/all to collect respective points.

Pattern 1: (10 pts):
=> Get all same numbers.
=> Play with at least X number of sides.

Pattern 2: (15 pts):
=> Make any scrore that is a prime number (3, 5, 7, 11, 13, so on).
=> And scrore at least 20 points or more.

Pattern 3: (5 pts):
=> Get more then half of dices each make score more then average.
=> Play with at least X number of dices.

Pattern 4: (8 pts):
=> Get all unique numbers.
=> Play with at least X number of dices.
=> Weight of sides over dices.

Pattern 5: (1 pts):
=> If didn't match any of above criteria.

|--------------------------------------------------------------------------------------------------------------|
=> Enter # of sides [2, 20]: 10
=> Enter # of dice [3, 6]: 6

=> You have rolled: [8, 4, 5, 9, 6, 9]
=> These die sum to 41 and have an average rounded value of 7
   X--> Pattern 1 does not match, some dices in [8, 4, 5, 9, 6, 9] has different values.
   @--> Pattern 2 matched! 41 is a prime number.
   @--> Pattern 3 matched! more then half of [8, 4, 5, 9, 6, 9] are greater then or equal to average of 7.
   X--> Pattern 4 does not match, some dices in [8, 4, 5, 9, 6, 9] has same values.
=> Your bonus factor is: 20
=> These dice are worth 114 points
=> Do you want to reroll any dice [(Y)es / (N)o]? y
=> Re-run all die at once or manually [(A)ll / (S)elective]? a
=> Are you sure [(Y)es / (N)o]? y
=> You have rolled: [1, 4, 1, 9, 4, 3]
=> These die sum to 22 and have an average rounded value of 4
   X--> Pattern 1 does not match, some dices in [1, 4, 1, 9, 4, 3] has different values.
   X--> Pattern 2 does not match, 22 is not a prime number.
   @--> Pattern 3 matched! more then half of [1, 4, 1, 9, 4, 3] are greater then or equal to average of 4.
   X--> Pattern 4 does not match, some dices in [1, 4, 1, 9, 4, 3] has same values.
=> Your bonus factor is: 5
=> These dice are worth 102 points
=> This was your first turn, lets go again!

=> You have rolled: [4, 10, 3, 8, 2, 1]
=> These die sum to 28 and have an average rounded value of 5
   X--> Pattern 1 does not match, some dices in [4, 10, 3, 8, 2, 1] has different values.
   X--> Pattern 2 does not match, 28 is not a prime number.
   X--> Pattern 3 does not match, less then half of [4, 10, 3, 8, 2, 1] are greater then or equal to average of 5.
   @--> Pattern 4 matched! all dices [4, 10, 3, 8, 2, 1] have an unique values!!!
=> Your bonus factor is: 8
=> These dice are worth 104 points
=> Do you want to reroll any dice [(Y)es / (N)o]? y
=> Re-run all die at once or manually [(A)ll / (S)elective]? s
   --> Reroll die 1 (was 4) [(Y)es / (N)o]? n
   --> Reroll die 2 (was 10) [(Y)es / (N)o]? y
   --> Reroll die 3 (was 3) [(Y)es / (N)o]? n
   --> Reroll die 4 (was 8) [(Y)es / (N)o]? y
   --> Reroll die 5 (was 2) [(Y)es / (N)o]? n
   --> Reroll die 6 (was 1) [(Y)es / (N)o]? y
=> Are you sure [(Y)es / (N)o]? y
=> You have rolled: [4, 1, 3, 5, 2, 1]
=> These die sum to 16 and have an average rounded value of 3
   X--> Pattern 1 does not match, some dices in [4, 1, 3, 5, 2, 1] has different values.
   X--> Pattern 2 does not apply, since maximum score is less then 20.
   @--> Pattern 3 matched! more then half of [4, 1, 3, 5, 2, 1] are greater then or equal to average of 3.
   X--> Pattern 4 does not match, some dices in [4, 1, 3, 5, 2, 1] has same values.
=> Your bonus factor is: 5
=> These dice are worth 101 points
=> This is your turn #3

=> You have rolled: [3, 1, 5, 4, 2, 7]
=> These die sum to 22 and have an average rounded value of 4
   X--> Pattern 1 does not match, some dices in [3, 1, 5, 4, 2, 7] has different values.
   X--> Pattern 2 does not match, 22 is not a prime number.
   @--> Pattern 3 matched! more then half of [3, 1, 5, 4, 2, 7] are greater then or equal to average of 4.
   @--> Pattern 4 matched! all dices [3, 1, 5, 4, 2, 7] have an unique values!!!
=> Your bonus factor is: 13
=> These dice are worth 105 points
=> Do you want to reroll any dice [(Y)es / (N)o]? n
=> Your score of 105 was average compared to other turn today.
=> Would you like to play another turn [(Y)es / (N)o]? n
=> Do you want to END GAME!!! [(Y)es / (N)o]? y

************************************************ Thank You!!! ************************************************
```
