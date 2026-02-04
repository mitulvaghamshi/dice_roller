import 'package:dice_roller/models/game_levels.dart';
import 'package:flutter/foundation.dart';

class GameState {
  GameState({required this.level, required this.onWin}) {
    reset();
  }

  final GameLevel level;
  final ValueChanged<Iterable<int>> onWin;

  final _dice = <int, int>{};
}

extension Utils on GameState {
  bool get showResults => _dice.length == level.dices;

  void showWinScreen() => onWin(_dice.values);

  void reset() {
    for (var i = 1; i <= level.dices; i++) {
      _dice[i] = 0;
    }
  }

  int getDiceValueFor(int number) {
    RangeError.checkValueInInterval(number, 1, 6, 'DiceNumber');
    return ArgumentError.checkNotNull(_dice[number], '_dice[$number]');
  }

  void setDiceValueFor(int number, int value) {
    _dice[number] = value;
  }
}
