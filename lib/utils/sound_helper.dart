import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SoundHelper {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playTap() async {
    await _player.play(AssetSource('sounds/tap.mp3'));
  }

  static Future<void> playWin() async {
    await _player.play(AssetSource('sounds/win.mp3'));
    HapticFeedback.mediumImpact();
  }

  static Future<void> playLose() async {
    await _player.play(AssetSource('sounds/lose.mp3'));
    HapticFeedback.vibrate();
  }

  static Future<void> playTie() async {
    await _player.play(AssetSource('sounds/tie.mp3'));
    HapticFeedback.selectionClick();
  }
}
