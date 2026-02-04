import 'dart:async';

import 'package:dice_roller/services/progress_service.dart';
import 'package:flutter/foundation.dart';

/// Encapsulates the player's progress.
class ProgressController extends ChangeNotifier {
  /// Creates a new instance of [ProgressController] backed by [service].
  ProgressController(ProgressService service) : _service = service {
    load();
  }

  final ProgressService _service;

  int _highestLevel = 0;

  /// The highest level that the player has reached so far.
  int get highestLevel => _highestLevel;

  /// Fetches the latest data from the backing persistence store.
  Future<void> load() async {
    debugPrint('Loading progress...');
    final level = await _service.highestLevel;
    if (level > _highestLevel) {
      _highestLevel = level;
      notifyListeners();
    } else if (level < _highestLevel) {
      _service.highestLevel = _highestLevel;
    }
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevel = 0;
    _service.highestLevel = _highestLevel;
    notifyListeners();
  }

  /// Registers [level] as reached.
  /// If this is higher than [highestLevel], it will update that
  /// value and save it to the injected persistence store.
  void setLevel(int level) {
    if (level <= _highestLevel) return;
    _highestLevel = level;
    _service.highestLevel = level;
    notifyListeners();
  }
}
