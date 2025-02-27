import 'package:dice_roller/src/models/game_levels.dart';
import 'package:flutter/foundation.dart';

@immutable
class GameState {
  GameState({required this.level, required this.onWin});

  final GameLevel level;
  final ValueChanged<Iterable<int>> onWin;

  final ValueNotifier<Map<int, int>> _diceValue = ValueNotifier({});
}

extension Utils on GameState {
  bool get showResults => _diceValue.value.length == level.dices;

  void showWinningScreen() =>
      onWin(_diceValue.value.entries.map((e) => e.value));

  void reset() {
    for (var i = 1; i <= level.dices; i++) {
      _diceValue.value[i] = 0;
    }
  }

  int getDiceValueFor(int number) {
    RangeError.checkValueInInterval(number, 1, 6, 'diceNumber');
    return _diceValue.value[number] ?? 1;
  }

  void setDiceValueFor(int number, int value) {
    _diceValue.value[number] = value;
  }
}
