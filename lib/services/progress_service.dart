/// An interface of persistence stores for the player's progress.
///
/// Implementations can range from simple in-memory storage through
/// local preferences to cloud saves.
abstract class ProgressService {
  const ProgressService();

  Future<int> get highestLevel;
  set highestLevel(int value);
}
