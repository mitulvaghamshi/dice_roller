import 'package:dice_roller/services/progress_service.dart';

/// An in-memory implementation of [ProgressService]. Useful for testing.
class MemoryProgressPersistence implements ProgressService {
  MemoryProgressPersistence();

  int _level = 0;

  @override
  Future<int> get highestLevel async => _level;

  @override
  set highestLevel(int value) => _level = value;
}
