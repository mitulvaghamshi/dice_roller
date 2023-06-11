/// An interface of persistence stores for the player's progress.
///
/// Implementations can range from simple in-memory storage through
/// local preferences to cloud saves.
abstract class ProgressPersistence {
  Future<int> getHighestLevelReached();
  Future<void> saveHighestLevelReached(int level);
}
