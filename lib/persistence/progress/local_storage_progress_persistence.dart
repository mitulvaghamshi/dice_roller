import 'package:dice_roller/persistence/progress/progress_persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An implementation of [ProgressPersistence] that uses
/// `package:shared_preferences`.
class LocalStorageProgressPersistence extends ProgressPersistence {
  final Future<SharedPreferences> instanceFuture =
      SharedPreferences.getInstance();

  @override
  Future<int> getHighestLevelReached() async {
    var prefs = await instanceFuture;
    return prefs.getInt('highestLevelReached') ?? 0;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    var prefs = await instanceFuture;
    await prefs.setInt('highestLevelReached', level);
  }
}
