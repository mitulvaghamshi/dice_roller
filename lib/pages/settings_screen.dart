import 'package:dice_roller/src/controllers/progress_controller.dart';
import 'package:dice_roller/src/controllers/settings_controller.dart';
import 'package:dice_roller/utils/messenger.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/name_dialog.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.read<Palette>().backgroundSettings,
    body: ResponsiveScreen(
      mainSlot: const _MainSlot(),
      bottomSlot: RoughButton(onTap: context.pop, child: const Text('Back')),
    ),
  );
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    return ListView(
      children: [
        const SizedBox(height: 60),
        const Text(
          'Settings',
          textAlign: .center,
          style: TextStyle(fontSize: 55, height: 1),
        ),
        const SizedBox(height: 60),
        ValueListenableBuilder<String>(
          valueListenable: settings.playerName,
          builder: (_, name, child) => RoughButton(
            onTap: () => NameDialog.show(context),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                const Text('Player name', style: TextStyle(fontSize: 20)),
                Text("'$name'", style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: settings.soundsOn,
          builder: (_, soundsOn, child) => RoughButton(
            onTap: settings.toggleSoundsOn,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                const Text('Sound FX', style: TextStyle(fontSize: 20)),
                Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: settings.musicOn,
          builder: (_, musicOn, child) => RoughButton(
            onTap: settings.toggleMusicOn,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                const Text('Music', style: TextStyle(fontSize: 20)),
                Icon(musicOn ? Icons.music_note : Icons.music_off),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        RoughButton(
          onTap: () {
            showBanner('Game progress has been reset.');
            context.read<ProgressController>().reset();
          },
          child: const Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text('Reset progress', style: TextStyle(fontSize: 20)),
              Icon(Icons.delete),
            ],
          ),
        ),
      ],
    );
  }
}
