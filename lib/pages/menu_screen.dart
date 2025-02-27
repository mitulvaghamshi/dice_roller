import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/src/controllers/settings_controller.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<Palette>().backgroundMain.dark,
      body: const ResponsiveScreen(
        mainAreaProminence: 0.45,
        mainSlot: _MainSlot(),
        bottomSlot: _BottomSlot(),
      ),
    );
  }
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: -0.1,
        child: const Text(
          'The Dice Roller',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 55, height: 1),
        ),
      ),
    );
  }
}

@immutable
class _BottomSlot extends StatelessWidget {
  const _BottomSlot();

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<SettingsController>();
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      RoughButton(
        onTap: () => const PlayRoute().go(context),
        child: const Text('Play'),
      ),
      const SizedBox(height: 10),
      RoughButton(
        // Pass -1 as a level if called from main menu screen,
        // this will allow to continue running session (if any).
        onTap: () => const GameRulesRoute().push(context),
        child: const Text('Game Rules'),
      ),
      const SizedBox(height: 10),
      RoughButton(
        // Pass -1 as a level if called from main menu screen,
        // this will allow to continue running session (if any).
        onTap: () => const SettingsRoute().go(context),
        child: const Text('Settings'),
      ),
      const SizedBox(height: 40),
      ValueListenableBuilder<bool>(
        valueListenable: controller.muted,
        builder: (context, muted, child) => RoughButton(
          onTap: controller.toggleMuted,
          fillColor: muted
              ? context.read<Palette>().backgroundMain.dark
              : context.read<Palette>().redPen,
          child: Icon(muted ? Icons.volume_off : Icons.volume_up, size: 30),
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }
}
