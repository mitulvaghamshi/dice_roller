import 'package:dice_roller/services/settings_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An implementation of [SettingsServiceat uses `package:shared_preferences`.
@immutable
class LocalStorageSettingsPersistence implements SettingsService {
  const LocalStorageSettingsPersistence();

  static final _prefs = SharedPreferencesAsync();

  @override
  Future<bool> get isMusicOn async {
    return await _prefs.getBool('musicOn') ?? true;
  }

  @override
  Future<bool> get isSoundsOn async {
    return await _prefs.getBool('soundsOn') ?? true;
  }

  @override
  Future<bool> get isMuted async {
    return await _prefs.getBool('mute') ?? false;
  }

  @override
  Future<String> get player async {
    return await _prefs.getString('player') ?? 'Player 1';
  }

  @override
  set isMusicOn(bool value) => _prefs.setBool('musicOn', value);

  @override
  set isSoundsOn(bool value) => _prefs.setBool('soundsOn', value);

  @override
  set isMuted(bool value) => _prefs.setBool('mute', value);

  @override
  set player(String value) => _prefs.setString('player', value);
}
