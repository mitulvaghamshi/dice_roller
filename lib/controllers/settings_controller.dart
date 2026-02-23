import 'dart:async';

import 'package:dice_roller/services/settings_service.dart';
import 'package:flutter/foundation.dart';

/// An class that holds settings like [player] or [music],
/// and saves them to an injected persistence store.
@immutable
class SettingsController {
  /// Creates a new instance of [SettingsController] backed by [service].
  SettingsController(SettingsService service) : _service = service {
    load();
  }

  final SettingsService _service;

  /// Whether or not the sound is on at all.
  /// This overrides both music and sound.
  final muted = ValueNotifier<bool>(false);
  final music = ValueNotifier<bool>(false);
  final sound = ValueNotifier<bool>(false);
  final player = ValueNotifier<String>('Rando!');

  /// Asynchronously loads values from the injected persistence store.
  Future<void> load() async {
    debugPrint('Loading settings...');
    // On the web, sound can only start after user interaction,
    // so we start muted there. On any other platform, we start unmuted.
    music.value = await _service.isMusicOn;
    sound.value = await _service.isSoundsOn;
    muted.value = await _service.isMuted ?? kIsWeb;
    player.value = await _service.player;
  }

  void toggleMusic() {
    music.value = !music.value;
    _service.isMusicOn = music.value;
  }

  void toggleSound() {
    sound.value = !sound.value;
    _service.isSoundsOn = sound.value;
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _service.isMuted = muted.value;
  }

  void setPlayer(String name) {
    player.value = name;
    _service.player = player.value;
  }
}
