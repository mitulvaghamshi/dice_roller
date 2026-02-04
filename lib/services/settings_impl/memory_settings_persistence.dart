import 'package:dice_roller/services/settings_service.dart';

/// An in-memory implementation of [SettingsServiceseful for testing.
class MemorySettingsPersistence implements SettingsService {
  MemorySettingsPersistence();

  bool _music = true;
  bool _sound = true;
  bool _muted = false;
  String _player = 'Player 1';

  @override
  Future<bool> get isMusicOn async => _music;

  @override
  Future<bool> get isSoundsOn async => _sound;

  @override
  Future<bool> get isMuted async => _muted;

  @override
  Future<String> get player async => _player;

  @override
  set isMusicOn(bool value) => _music = value;

  @override
  set isSoundsOn(bool value) => _sound = value;

  @override
  set isMuted(bool value) => _muted = value;

  @override
  set player(String value) => _player = value;
}
