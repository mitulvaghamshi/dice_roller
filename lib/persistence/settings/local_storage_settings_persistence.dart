import 'package:dice_roller/persistence/settings/settings_persistence.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An implementation of [SettingsPersistence] that uses
/// `package:shared_preferences`.
@immutable
class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instance = SharedPreferences.getInstance();

  @override
  Future<bool> getMusicOn() async {
    var prefs = await instance;
    return prefs.getBool('musicOn') ?? true;
  }

  @override
  Future<bool> getMuted({required bool defaultValue}) async {
    var prefs = await instance;
    return prefs.getBool('mute') ?? defaultValue;
  }

  @override
  Future<String> getPlayerName() async {
    var prefs = await instance;
    return prefs.getString('playerName') ?? 'Player';
  }

  @override
  Future<bool> getSoundsOn() async {
    var prefs = await instance;
    return prefs.getBool('soundsOn') ?? true;
  }

  @override
  Future<void> saveMusicOn(bool value) async {
    var prefs = await instance;
    await prefs.setBool('musicOn', value);
  }

  @override
  Future<void> saveMuted(bool value) async {
    var prefs = await instance;
    await prefs.setBool('mute', value);
  }

  @override
  Future<void> savePlayerName(String value) async {
    var prefs = await instance;
    await prefs.setString('playerName', value);
  }

  @override
  Future<void> saveSoundsOn(bool value) async {
    var prefs = await instance;
    await prefs.setBool('soundsOn', value);
  }
}
