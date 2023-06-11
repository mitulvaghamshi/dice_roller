import 'package:dice_roller/models/game_levels.dart';
import 'package:flutter/foundation.dart';

class GameState extends ChangeNotifier {
  GameState({required this.level, required this.onWin});

  final GameLevel level;
  final ValueChanged<Iterable<int>> onWin;

  final Map<int, int> _diceValue = {};

  bool get showResults => _diceValue.length == level.dices;

  void showWiningScreen() => onWin(_diceValue.entries.map((e) => e.value));

  void reset() {
    for (var i = 1; i <= level.dices; i++) {
      _diceValue[i] = 0;
    }
  }

  int getDiceValueFor(int number) {
    assert(number >= 1 && number <= 6,
        'Invalid dice number, Range (1-6) inclusive.');
    return _diceValue[number] ?? 1;
  }

  void setDiceValueFor(int number, int value) {
    _diceValue[number] = value;
    notifyListeners();
  }
}
