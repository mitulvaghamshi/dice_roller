import 'package:dice_roller/src/services/settings_service.dart';

/// An in-memory implementation of [SettingsServiceseful for testing.
class MemorySettingsPersistence implements SettingsService {
  MemorySettingsPersistence();

  bool musicOn = true;
  bool soundsOn = true;
  bool muted = false;
  String playerName = 'Player X';

  @override
  Future<bool> get isMusicOn async => musicOn;

  @override
  Future<bool> get isMuted async => muted;

  @override
  Future<String> get player async => playerName;

  @override
  Future<bool> get isSoundsOn async => soundsOn;

  @override
  Future<void> saveMusicOn(bool value) async => musicOn = value;

  @override
  Future<void> saveMuted(bool value) async => muted = value;

  @override
  Future<void> savePlayerName(String value) async => playerName = value;

  @override
  Future<void> saveSoundsOn(bool value) async => soundsOn = value;
}
