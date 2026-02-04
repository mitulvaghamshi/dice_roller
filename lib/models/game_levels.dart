import 'package:dice_roller/models/pattern.dart';
import 'package:flutter/material.dart';

const gameLevels = <GameLevel>[
  .new(level: 1, dices: 1, sides: 1),
  .new(level: 2, dices: 1, sides: 2),
  .new(level: 3, dices: 1, sides: 3),
  .new(level: 4, dices: 1, sides: 4),
  .new(level: 5, dices: 1, sides: 5),
  .new(level: 6, dices: 1, sides: 1),
  .new(level: 7, dices: 2, sides: 2),
  .new(level: 8, dices: 3, sides: 3),
  .new(level: 9, dices: 4, sides: 4),
  .new(level: 10, dices: 5, sides: 5),
  .new(level: 11, dices: 6, sides: 6),
];

@immutable
class GameLevel {
  const GameLevel({
    required this.level,
    required this.dices,
    required this.sides,
  }) : assert(dices >= 1 && dices <= 6, 'Dices must be between 1 and 6'),
       assert(sides >= 1 && sides <= 20, 'Sides must be between 1 and 20');

  final int level;
  final int dices;
  final int sides;

  Pattern pattern1({required int length}) {
    if (sides < 4) return .p1r1();
    if (length == 1) return .p1r2();
    return .p1r3();
  }

  Pattern pattern2({required int sum}) {
    if (sum < 20) return .p2r1();
    var isPrime = {for (var i = 2; i < dices; i++) sum % i == 0}.length == 1;
    if (isPrime) return .p2r2();
    return .p2r3();
  }

  Pattern pattern3({required int sum, required Iterable<int> values}) {
    if (dices < 5) return .p3r1();
    var count = 0;
    for (var val in values) {
      if (val >= sum / dices) count++;
    }
    if (count >= dices ~/ 2) return .p3r2();
    return .p3r3();
  }

  Pattern pattern4({required int length}) {
    if (dices < 4 || sides < dices) return .p4r1();
    if (length == dices) return .p4r2();
    return .p4r3();
  }

  Pattern pattern5({required int bonus}) {
    if (bonus == 0) return .p5r1();
    return .p5r2();
  }
}
