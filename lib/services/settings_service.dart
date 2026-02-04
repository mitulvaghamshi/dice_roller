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

  set isMusicOn(bool value);
  set isSoundsOn(bool value);
  set isMuted(bool value);
  set player(String value);
}
