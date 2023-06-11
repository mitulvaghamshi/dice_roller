import 'package:dice_roller/persistence/settings/settings_persistence.dart';
import 'package:flutter/foundation.dart';

/// An class that holds settings like [playerName] or [musicOn],
/// and saves them to an injected persistence store.
class SettingsController {
  /// Creates a new instance of [SettingsController] backed by [persistence].
  SettingsController({required SettingsPersistence persistence})
      : _persistence = persistence;

  final SettingsPersistence _persistence;

  /// Whether or not the sound is on at all.
  /// This overrides both music and sound.
  ValueNotifier<bool> muted = ValueNotifier(false);
  ValueNotifier<bool> musicOn = ValueNotifier(false);
  ValueNotifier<bool> soundsOn = ValueNotifier(false);
  ValueNotifier<String> playerName = ValueNotifier('Player 1');

  /// Asynchronously loads values from the injected persistence store.
  Future<void> loadFromStore() async {
    await Future.wait([
      // On the web, sound can only start after user interaction,
      // so we start muted there.
      // On any other platform, we start unmuted.
      _persistence
          .getMuted(defaultValue: kIsWeb)
          .then((value) => muted.value = value),
      _persistence.getSoundsOn().then((value) => soundsOn.value = value),
      _persistence.getMusicOn().then((value) => musicOn.value = value),
      _persistence.getPlayerName().then((value) => playerName.value = value),
    ]);
  }

  void setPlayerName(String name) {
    playerName.value = name;
    _persistence.savePlayerName(playerName.value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _persistence.saveMusicOn(musicOn.value);
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _persistence.saveMuted(muted.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.saveSoundsOn(soundsOn.value);
  }
}
