import 'package:flutter/material.dart';

@immutable
class Bonus {
  const Bonus({required this.reason, this.points = 0});

  final int points;
  final String reason;
}

@immutable
class GameLevel {
  const GameLevel({
    required this.level,
    required this.dices,
    required this.sides,
  });

  // assert(dices >= 3 && dices <= 6, "The number of dices should be minimum 3 and maximum 6.");
  // assert(sides >= 2 && dices <= 20, "The number of sides should be minimum 2 and maximum 20.");

  final int level;
  final int dices;
  final int sides;

  Bonus pattern1({required int unique}) {
    if (sides < 4) {
      return const Bonus(
        reason: 'Pattern 1 does not apply, sides are less then 4.',
      );
    }
    if (unique == 1) {
      return const Bonus(
        points: 10,
        reason: 'Pattern 1 matched! all dices have same values (10 pts).',
      );
    }
    return const Bonus(
      reason: 'Pattern 1 does not match, some dice(s) have different values.',
    );
  }

  Bonus pattern2({required int sum}) {
    if (sum < 20) {
      return const Bonus(
        reason: 'Pattern 2 does not apply, maximum score is less then 20.',
      );
    }
    var isPrime = {for (var i = 2; i < dices; i++) sum % i == 0}.length == 1;
    if (isPrime) {
      return Bonus(
        points: 15,
        reason: 'Pattern 2 matched! $sum is a prime number (15 pts).',
      );
    }
    return Bonus(
      reason: 'Pattern 2 does not match, $sum is not a prime number.',
    );
  }

  Bonus pattern3({required int sum, required Iterable<int> values}) {
    if (dices < 5) {
      return const Bonus(
        reason: 'Pattern 3 does not apply, dices are less then 5.',
      );
    }
    var count = 0;
    for (var val in values) {
      if (val >= sum / dices) count++;
    }
    if (count >= dices ~/ 2) {
      return const Bonus(
        points: 5,
        reason: 'Pattern 3 matched! at least half '
            'of dices have same value as average (5 pts).',
      );
    }
    return const Bonus(
      reason: 'Pattern 3 does not match, less then '
          'half dices have same value as average.',
    );
  }

  Bonus pattern4({required int unique}) {
    if (dices < 4 || sides < dices) {
      return const Bonus(
        reason: 'Pattern 4 does not apply, either dices '
            'are less then 4 or sides are less then dices.',
      );
    }
    if (unique == dices) {
      return const Bonus(
        points: 8,
        reason: 'Pattern 4 matched! all dices have unique values (8 pts).',
      );
    }
    return const Bonus(
      reason: 'Pattern 4 does not match, some dices have same values.',
    );
  }

  Bonus pattern5({required int bonus}) {
    if (bonus == 0) {
      const Bonus(
        points: 1,
        reason: 'Since you don\'t matched any other '
            'pattern, Pattern 5 is matched (1 pt).',
      );
    }
    return const Bonus(
      reason: 'Pattern 5 does not apply, since you matched other pattern(s).',
    );
  }
}

const gameLevels = [
  GameLevel(level: 1, dices: 1, sides: 1),
  GameLevel(level: 2, dices: 1, sides: 2),
  GameLevel(level: 3, dices: 1, sides: 3),
  GameLevel(level: 4, dices: 1, sides: 4),
  GameLevel(level: 5, dices: 1, sides: 5),
  //
  GameLevel(level: 6, dices: 1, sides: 1),
  GameLevel(level: 7, dices: 2, sides: 2),
  GameLevel(level: 8, dices: 3, sides: 3),
  GameLevel(level: 9, dices: 4, sides: 4),
  GameLevel(level: 10, dices: 5, sides: 5),
  GameLevel(level: 11, dices: 6, sides: 6),
];
