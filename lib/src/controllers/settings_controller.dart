import 'dart:async';

import 'package:dice_roller/src/services/settings_service.dart';
import 'package:flutter/foundation.dart';

/// An class that holds settings like [playerName] or [musicOn],
/// and saves them to an injected persistence store.
@immutable
class SettingsController {
  /// Creates a new instance of [SettingsController] backed by [service].
  SettingsController(SettingsService service) : _service = service;

  final SettingsService _service;

  /// Whether or not the sound is on at all.
  /// This overrides both music and sound.
  final muted = ValueNotifier<bool>(false);
  final musicOn = ValueNotifier<bool>(false);
  final soundsOn = ValueNotifier<bool>(false);
  final playerName = ValueNotifier<String>('Player 1');

  /// Asynchronously loads values from the injected persistence store.
  Future<void> load() async {
    // On the web, sound can only start after user interaction,
    // so we start muted there. On any other platform, we start unmuted.
    musicOn.value = await _service.isMusicOn;
    soundsOn.value = await _service.isSoundsOn;
    muted.value = await _service.isMuted ?? kIsWeb;
    playerName.value = await _service.player;
  }

  void setPlayerName(String name) {
    playerName.value = name;
    unawaited(_service.savePlayerName(playerName.value));
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    unawaited(_service.saveMusicOn(musicOn.value));
  }

  void toggleMuted() {
    muted.value = !muted.value;
    unawaited(_service.saveMuted(muted.value));
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    unawaited(_service.saveSoundsOn(soundsOn.value));
  }
}
