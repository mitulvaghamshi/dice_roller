import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/persistence/settings_controller.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var palette = context.read<Palette>();
    var settingsController = context.watch<SettingsController>();
    const spacer10 = SizedBox(height: 10);

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        mainAreaProminence: 0.45,
        mainSlot: Center(
          child: Transform.rotate(
            angle: -0.1,
            child: const Text(
              'The Dice Roller!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 55, height: 1),
            ),
          ),
        ),
        bottomSlot: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          RoughButton(
            onTap: () => const PlayRoute().go(context),
            child: const Text('Play'),
          ),
          spacer10,
          RoughButton(
            // Pass -1 as a level if called from main menu screen,
            // this will allow to continue running session (if any).
            onTap: () => const GameRulesRoute(level: -1).go(context),
            child: const Text('Game Rules'),
          ),
          spacer10,
          RoughButton(
            // Pass -1 as a level if called from main menu screen,
            // this will allow to continue running session (if any).
            onTap: () => const SettingsRoute(level: -1).go(context),
            child: const Text('Settings'),
          ),
          const SizedBox(height: 40),
          ValueListenableBuilder<bool>(
            valueListenable: settingsController.muted,
            builder: (context, muted, child) => RoughButton(
              onTap: settingsController.toggleMuted,
              fillColor: muted ? palette.backgroundMain : palette.redPen,
              child: Icon(muted ? Icons.volume_off : Icons.volume_up, size: 30),
            ),
          ),
          spacer10,
        ]),
      ),
    );
  }
}
