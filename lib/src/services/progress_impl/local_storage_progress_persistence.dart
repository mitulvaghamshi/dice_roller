import 'package:dice_roller/src/services/progress_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An implementation of [ProgressService] that uses
/// `package:shared_preferences`.
@immutable
class LocalStorageProgressPersistence implements ProgressService {
  // /* const */ LocalStorageProgressPersistence();

  final Future<SharedPreferences> _instance = SharedPreferences.getInstance();

  @override
  Future<int> get highestLevelReached async {
    var prefs = await _instance;
    return prefs.getInt('highestLevelReached') ?? 0;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    var prefs = await _instance;
    await prefs.setInt('highestLevelReached', level);
  }
}
