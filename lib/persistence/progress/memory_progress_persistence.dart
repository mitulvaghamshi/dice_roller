import 'package:dice_roller/persistence/progress/progress_persistence.dart';

/// An in-memory implementation of [ProgressPersistence].
/// Useful for testing.
class MemoryProgressPersistence implements ProgressPersistence {
  int level = 0;

  @override
  Future<int> getHighestLevelReached() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return level;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    this.level = level;
  }
}
