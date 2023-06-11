import 'package:dice_roller/persistence/progress_controller.dart';
import 'package:dice_roller/persistence/settings_controller.dart';
import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/utils/snack_bar.dart';
import 'package:dice_roller/widgets/name_dialog.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsController>();
    var palette = context.read<Palette>();
    const spacer60 = SizedBox(height: 60);
    const spacer16 = SizedBox(height: 16);

    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreen(
        mainSlot: ListView(children: [
          spacer60,
          const Text(
            'Settings',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 55, height: 1),
          ),
          spacer60,
          ValueListenableBuilder<String>(
            valueListenable: settings.playerName,
            builder: (_, name, child) => RoughButton(
              onTap: () => NameDialog.show(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Player name',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "'$name'",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          spacer16,
          ValueListenableBuilder<bool>(
            valueListenable: settings.soundsOn,
            builder: (context, soundsOn, child) => RoughButton(
              onTap: settings.toggleSoundsOn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sound FX', style: TextStyle(fontSize: 20)),
                  Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                ],
              ),
            ),
          ),
          spacer16,
          ValueListenableBuilder<bool>(
            valueListenable: settings.musicOn,
            builder: (context, musicOn, child) => RoughButton(
              onTap: settings.toggleMusicOn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Music', style: TextStyle(fontSize: 20)),
                  Icon(musicOn ? Icons.music_note : Icons.music_off),
                ],
              ),
            ),
          ),
          spacer16,
          RoughButton(
            onTap: () {
              context.read<ProgressController>().reset();
              showBanner('Player progress has been reset.');
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reset progress', style: TextStyle(fontSize: 20)),
                Icon(Icons.delete),
              ],
            ),
          )
        ]),
        bottomSlot: RoughButton(
          onTap: () => _onClose(context),
          child: const Text('Back'),
        ),
      ),
    );
  }
}

extension on SettingsScreen {
  void _onClose(BuildContext context) {
    if (level == -1) {
      context.pop();
    } else {
      PlaySessionRoute(level: level).go(context);
    }
  }
}
