import 'dart:async';

import 'package:dice_roller/persistence/progress/progress_persistence.dart';
import 'package:flutter/foundation.dart';

/// Encapsulates the player's progress.
class ProgressController extends ChangeNotifier {
  /// Creates an instance of [ProgressController] backed by an injected
  /// persistence [store].
  ProgressController(ProgressPersistence store) : _store = store;

  final ProgressPersistence _store;

  static const maxHighestScoresPerPlayer = 0;

  int _highestLevelReached = 0;

  /// The highest level that the player has reached so far.
  int get highestLevelReached => _highestLevelReached;

  /// Fetches the latest data from the backing persistence store.
  Future<void> getFromStore() async {
    var level = await _store.getHighestLevelReached();
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _store.saveHighestLevelReached(_highestLevelReached);
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
      unawaited(_store.saveHighestLevelReached(level));
    }
  }
}
