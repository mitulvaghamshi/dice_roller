import 'package:dice_roller/src/services/settings_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An implementation of [SettingsServiceat uses
/// `package:shared_preferences`.
@immutable
class LocalStorageSettingsPersistence implements SettingsService {
  const LocalStorageSettingsPersistence();

  Future<SharedPreferences> get _instance async => await .getInstance();

  @override
  Future<bool> get isMusicOn async {
    final prefs = await _instance;
    return prefs.getBool('musicOn') ?? true;
  }

  @override
  Future<bool?> get isMuted async {
    final prefs = await _instance;
    return prefs.getBool('mute');
  }

  @override
  Future<String> get player async {
    final prefs = await _instance;
    return prefs.getString('playerName') ?? 'Player';
  }

  @override
  Future<bool> get isSoundsOn async {
    final prefs = await _instance;
    return prefs.getBool('soundsOn') ?? true;
  }

  @override
  Future<void> saveMusicOn(bool value) async {
    final prefs = await _instance;
    await prefs.setBool('musicOn', value);
  }

  @override
  Future<void> saveMuted(bool value) async {
    final prefs = await _instance;
    await prefs.setBool('mute', value);
  }

  @override
  Future<void> savePlayerName(String value) async {
    final prefs = await _instance;
    await prefs.setString('playerName', value);
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    final prefs = await _instance;
    await prefs.setBool('soundsOn', value);
  }
}
