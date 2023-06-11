# # [random] Library used to genetare random numbers.
#   [functools] Library provides Tools for working with functions and callable objects.
from functools import reduce
from random import randint
# # [End of import]


# # [welcome] Module to display simple message and to screen with formatted output.
#   Make sure your console is at least 120 characters [approximate 8-9 inches] wide for proper output.
def welcome():
    print('|' + '-' * 120 + '|')
    print('|' + '{:-^120s}'.format('Welcome to Dice Game, Good Luck!') + '|')
    print('|' + '-' * 120 + '|')
    print("The game is based on 5 different patterns..., match any/all to collect respective points.\n")
    print("Pattern 1: (10 pts):\n=> Get all same numbers.\n=> Play with at least X number of sides.\n")
    print("Pattern 2: (15 pts):\n=> Make any scrore that is a prime number (3, 5, 7, 11, 13, so on).\n=> And scrore at least 20 points or more.\n")
    print("Pattern 3: (5 pts):\n=> Get at least half of dices each make score more then average.\n=> Play with at least X number of dices.\n")
    print("Pattern 4: (8 pts):\n=> Get all unique numbers.\n=> Play with at least X number of dices.\n=> Weight of sides over dices.\n")
    print("Pattern 5: (1 pts):\n=> If didn't match any of above pattern.\n")
    print('|' + '-' * 120 + '|')
# # [End welcome]


# # [get_input] Module to get both number of sides and dices from user with validation.
#   If checks for valid positive integer between given range (inclusive).
def get_input(prompt, minN, maxN):
    while True:
        choice = input(f'=> Enter # of {prompt} [{minN}, {maxN}]: ')
        if not choice.isdigit() or (int(choice) < minN or int(choice) > maxN):
            print('   --> Its not a valid positive number in range, please try again!!!')
        else:
            return int(choice)
# # [End get_input]


# # [add_all] Module used to add up all die togather and return a total.
#   [lambda] A single line anonymous function for reduced code.
#   [reduce] Apply a function of two arguments cumulatively to the items of a sequence,
#   from left to right, so as to reduce the sequence to a single value.
#   For example, reduce(lambda x, y: x+y, [1, 2, 3, 4, 5]) calculates ((((1+2)+3)+4)+5).
#   If initial is present, it is placed before the items of the sequence in the calculation,
#   and serves as a default when the sequence is empty.
def add_all(roll_list):
    return reduce(lambda a, b: a + b, roll_list)
# # [End add_all]


# # [average] Calculates average of all played die values
#   [round] Round a number to a given precision in decimal digits.
#   The return value is an integer if ndigits is omitted or None.
#   Otherwise the return value has the same type as the number. ndigits may be negative.
def average(total, length):
    avg = round(total / length)
    print(f'=> These die sum to {total} and have an average rounded value of {avg}')
    return avg
# # [end average]


# # [to_percent] Calculates percentage value of given parameters
#   First: Devide total of die with the multiplication value of sides and dice
#   Second: Multiply with calculated bonus value
#   Third: Add value of student ID moduled by 500
def to_percent(total, mul, bonus, s_id):
    return round((total / mul) * bonus + (s_id % 500))
# # [End to_percent]


# # [is_prime] Module to check whether given number is prime or not.
#   [set] Returns new empty set object set(iterable) -> new set object
#   Build an unordered collection of unique elements.
#   I.e. list of [5, 5, 5, 5, 5] will becomes list of [5] - removes all duplicates.
#   Finally, if length of set is 1 then given number is prime and return True, False othervise.
def is_prime(score):
    return len(set([score % n == 0 for n in range(2, score)])) == 1
# # [End is_prime]


# # [pattern1] Function which checks if pattern 1 matched or not.
#   Condition: number of sides is greater then or equal to 4 and all the played die have same values.
#   i.e. [5, 5, 5, 5, 5]
#   Valid bonus is 10
def pattern1(sides, roll_list):
    if sides >= 4:
        if len(set(roll_list)) == 1:
            print(f'   @--> Pattern 1 matched! all dices {roll_list} are equal.')
            return 10
        else:
            print(f'   X--> Pattern 1 does not match, some dices in {roll_list} has different values.')
            return 0
    else:
        print('   X--> Pattern 1 does not applied since sides are less then 4.')
        return 0
# # [End pattern1]


# # [pattern2] Function which checks if pattern 2 matched or not.
#   Condition: total of all played die is both grater then or equal to 20 and a prime number.
#   i.e. [1, 9, 7, 2, 1, 1] is 21 - a prime number.
#   Valid bonus is 15
def pattern2(score):
    if score >= 20:
        if is_prime(score):
            print(f'   @--> Pattern 2 matched! {score} is a prime number.')
            return 15
        else:
            print(f'   X--> Pattern 2 does not match, {score} is not a prime number.')
            return 0
    else:
        print('   X--> Pattern 2 does not apply, since maximum score is less then 20.')
        return 0
# # [End pattern2]


# # [pattern3] Function which checks if pattern 3 matched or not.
#   Condition: number of dice is grater then or equal to 5 and at least half of all die is greater then or equal to average value.
#   i.e. [5, 9, 7, 2, 1, 1] average = 4, and [5, 9, 7] is greater or equal to 4.
#   Valid bonus is 5
#
#   Simplified logic:
#   counter = 0
#   for item in roll_list:
#       if item >= avg:
#           counter = counter + 1
#   if counter >= len(roll_list) / 2:
#       return True
#   else:
#       return False
def pattern3(dice, avg, roll_list):
    if dice >= 5:
        if len(list(filter(lambda item: item == True, [item >= avg for item in roll_list]))) >= len(roll_list) / 2:
            print(f'   @--> Pattern 3 matched! at least half of {roll_list} are greater then or equal to average of {avg}.')
            return 5
        else:
            print(f'   X--> Pattern 3 does not match, less then half of {roll_list} are greater then or equal to average of {avg}.')
            return 0
    else:
        print('   X--> Pattern 3 does not apply, dices are less then 5.')
        return 0
# # [End pattern 3]


# # [pattern4] Function which checks if pattern 4 matched or not.
#   Condition: number of dice is grater then 4 and number of sides is greater then dice.
#   i.e. sides = 7, dice = 5
#   Valid bonus is 8
def pattern4(sides, dices, roll_list):
    if dices > 4 and sides > dices:
        if len(set(roll_list)) == len(roll_list):
            print(f'   @--> Pattern 4 matched! all dices {roll_list} have an unique values!!!')
            return 8
        else:
            print(f'   X--> Pattern 4 does not match, some dices in {roll_list} has same values.')
            return 0
    else:
        print('   X--> Pattern 4 does not apply, either dice is less then 4 or sides are less then dice!!!')
        return 0
# # [End pattern4]


# # [pattern5] This function takes all four calculated bonus values and check if any matched
#   If any of four pattern does not matched then only pattern5 get matched.
#   Valid bonus 1
def pattern5(bonus_list):
    bonus_total = add_all(bonus_list)
    if bonus_total == 0:
        print('   @--> Since you dont matched any pattern, Pattern 5 is matched!')
        return 1
    return bonus_total
# # [End pattern5]


# # [bonus_factor] Function call all five pattern and returns total of all matched pattern.
def bonus_factor(sides, dices, total, avg, roll_list):
    return pattern5([
        pattern1(sides, roll_list),
        pattern2(total),
        pattern3(dices, avg, roll_list),
        pattern4(sides, dices, roll_list),
    ])
# # [End bonus_factor]


# # [roll_die] Function to roll die by number of sides and dices.
def roll_die(sides, dices):
    roll_list = [randint(1, sides) for _ in range(dices)]
    print(f'\n=> You have rolled: {roll_list}')
    return roll_list
# # [End roll_die]


# # [re_roll_die] Function to re roll one or all dice.
#   Player can re run all die togather or can run each die manually.
def re_roll_die(roll_list):
    # Ask user to reroll any die
    while True:
        reroll = input('=> Do you want to reroll any dice [(Y)es / (N)o]? ').lower()[0]
        if not reroll in ['y', 'n']:
            print('   --> Invalid input, try again...')
        elif reroll == 'y':
            temp_list = []
            # Ask user to reroll all die togather
            while True:
                run_all = input('=> Re-run all die at once or manually [(A)ll / (S)elective]? ').lower()[0]
                if not run_all in ['a', 's']:
                    print('   --> Invalid input, try again...')
                elif run_all == 'a':
                    temp_list = list(map(lambda side: randint(1, side), roll_list))
                    break
                elif run_all == 's':
                    # Ask user for each die to re roll
                    for i in range(len(roll_list)):
                        while True:
                            do_roll = input(f'   --> Reroll die {i+1} (was {roll_list[i]}) [(Y)es / (N)o]? ').lower()[0]
                            if do_roll == 'y':
                                new_roll = randint(1, roll_list[i])
                                temp_list.append(new_roll)
                                break
                            elif do_roll == 'n':
                                temp_list.append(roll_list[i])
                                break
                            else:
                                print('\t--> Invalid input, try again...')
                    break
            # Confirm to re-roll
            while True:
                is_sure = input('=> Are you sure [(Y)es / (N)o]? ').lower()[0]
                if not is_sure in ['y', 'n']:
                    print('   --> Invalid input, try again...')
                elif is_sure == 'y':
                    print(f'=> You have rolled: {temp_list}')
                    return temp_list
                else:
                    print('=> Ok, try one more time...')
                    break
        elif reroll == 'n':
            return False
        else:
            print('   --> Invalid input, try again...')
# # [End re_roll_die]


# # [play_game] Function to start game and keep track of all calculated values and user progress.
def play_game():
    is_first_run = True
    total_list = []
    roll_list = []
    counter = 0

    # Get number of sides and dice
    sides = get_input('sides', 2, 20)
    dices = get_input('dice', 3, 6)

    # Repeat untill user ends manually.
    while True:
        if is_first_run:
            roll_list = roll_die(sides, dices)
        else:
            result = re_roll_die(roll_list)
            if not isinstance(result, bool):
                roll_list = result
            else:
                m_list = [item[1] for item in total_list]
                m_list.sort()
                print(f'=> Your score of {total_list[counter-1][1]} {"was average" if total_list[counter-1][1] >= total_list[len(m_list)-1][1] else "was less"} compared to other turns today.')

                # Ask user to play again.
                while True:
                    another = input('=> Would you like to play another turn [(Y)es / (N)o]? ').lower()[0]
                    if not another in ['y', 'n']:
                        print('   --> Invalid input, try again')
                    elif another == 'y':
                        roll_list = roll_die(sides, dices)
                        break
                    else:
                        # Warn user before terminating the game.
                        while True:
                            is_end = input('=> Do you want to END GAME!!! [(Y)es / (N)o]? ').lower()[0]
                            if not is_end in ['y', 'n']:
                                print('   --> Invalid input, try again!!!')
                            elif is_end == 'y':
                                print('\n{:*^120s}'.format(' Thank You!!! '))
                                exit(0)
                            else:
                                break
        # Calculate required values.
        total = add_all(roll_list)
        avg = average(total, len(roll_list))
        bonus = bonus_factor(sides, dices, total, avg, roll_list)
        points = to_percent(total, sides * dices, bonus, 821600)

        print(f'=> Your bonus factor is: {bonus}')
        print(f'=> These dice are worth {points} points')

        # Keep track of all played game by perticalar user.
        total_list.append([counter, points])
        counter += 1

        if is_first_run:
            is_first_run = False
        elif counter == 2:
            print('=> This was your first turn, lets go again, its free!!!')
            is_first_run = True
        else:
            print(f'=> This is your turn #{counter-1}')
            is_first_run = True
# # [End play_game]

# # [main] Entry point.


def main():
    welcome()
    play_game()
# # [End main]


# # [__name__] is the python default variable of type string that holds name of entry method.
#   [__main__] is the name of the environment where top-level code is run.
#   This condition is optional; can be replaced by just method call: `main()`
if __name__ == '__main__':
    main()
# # [End if]
