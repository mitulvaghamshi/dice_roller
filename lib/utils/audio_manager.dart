import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

@immutable
mixin AudioManager {
  static final _player = AudioPlayer();

  static Future<void> playUrl(String url) async {
    await _player.stop();
    await _player.play(UrlSource(url));
  }

  // Path should NOT include 'assets/' prefix if defined that way in pubspec
  static Future<void> playAsset(String fileName) async {
    await _player.stop();
    await _player.play(AssetSource(fileName));
  }

  static Future<void> pause() async => _player.pause();
  static Future<void> stop() async => _player.stop();
  static Future<void> resume() async => _player.resume();
}
