import 'dart:async';

import 'package:dice_roller/src/services/progress_service.dart';
import 'package:flutter/foundation.dart';

/// Encapsulates the player's progress.
class ProgressController extends ChangeNotifier {
  /// Creates a new instance of [ProgressController] backed by [service].
  ProgressController(ProgressService service) : _service = service;

  final ProgressService _service;

  static const maxHighestScoresPerPlayer = 0;

  int _highestLevelReached = 0;

  /// The highest level that the player has reached so far.
  int get highestLevelReached => _highestLevelReached;

  /// Fetches the latest data from the backing persistence store.
  Future<void> load() async {
    final level = await _service.highestLevelReached;
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _service.saveHighestLevelReached(_highestLevelReached);
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    unawaited(_service.saveHighestLevelReached(_highestLevelReached));
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
      unawaited(_service.saveHighestLevelReached(level));
    }
  }
}
