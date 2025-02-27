import 'package:dice_roller/src/services/progress_service.dart';

/// An in-memory implementation of [ProgressService]. Useful for testing.
class MemoryProgressPersistence implements ProgressService {
  MemoryProgressPersistence();

  int level = 0;

  @override
  Future<int> get highestLevelReached async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return level;
  }

  @override
  Future<void> saveHighestLevelReached(int level) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    this.level = level;
  }
}
