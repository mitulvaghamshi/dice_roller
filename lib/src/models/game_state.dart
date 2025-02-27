import 'package:dice_roller/src/models/game_levels.dart';
import 'package:flutter/foundation.dart';

@immutable
class GameState {
  GameState({required this.level, required this.onWin});

  final GameLevel level;
  final ValueChanged<Iterable<int>> onWin;

  final _dice = ValueNotifier<Map<int, int>>({});
}

extension Utils on GameState {
  bool get showResults => _dice.value.length == level.dices;

  void showWinScreen() => onWin(_dice.value.values);

  void reset() {
    for (var i = 1; i <= level.dices; i++) {
      _dice.value[i] = 0;
    }
  }

  int getDiceValueFor(int number) {
    RangeError.checkValueInInterval(number, 1, 6, 'DiceNumber');
    return _dice.value[number] ?? 1;
  }

  void setDiceValueFor(int number, int value) {
    _dice.value[number] = value;
  }
}
