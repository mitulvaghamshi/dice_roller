/// An interface of persistence stores for settings.
///
/// Implementations can range from simple in-memory storage through
/// local preferences to cloud-based solutions.
abstract class SettingsService {
  const SettingsService();

  Future<bool> get isMusicOn;
  Future<bool> get isSoundsOn;
  Future<bool?> get isMuted;
  Future<String> get player;

  Future<void> saveMusicOn(bool value);
  Future<void> saveSoundsOn(bool value);
  Future<void> saveMuted(bool value);
  Future<void> savePlayerName(String value);
}
