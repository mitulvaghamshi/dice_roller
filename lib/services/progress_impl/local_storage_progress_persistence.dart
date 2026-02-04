import 'package:dice_roller/services/progress_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Implementation of [ProgressService] that uses `package:shared_preferences`.
@immutable
class LocalStorageProgressPersistence implements ProgressService {
  const LocalStorageProgressPersistence();

  static final _prefs = SharedPreferencesAsync();

  @override
  Future<int> get highestLevel async {
    return await _prefs.getInt('highestLevel') ?? 0;
  }

  @override
  set highestLevel(int level) => _prefs.setInt('highestLevel', level);
}
