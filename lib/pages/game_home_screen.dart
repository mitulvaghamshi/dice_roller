import 'package:dice_roller/controllers/settings_controller.dart';
import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class GameHomeScreen extends StatelessWidget {
  const GameHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.read<Palette>().backgroundMainSet.dark,
    body: const ResponsiveScreen(
      mainSlot: _MainSlot(),
      bottomSlot: _BottomSlot(),
    ),
  );
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot();

  @override
  Widget build(BuildContext context) => Center(
    child: Transform.rotate(
      angle: 6,
      child: const Text(
        'The Dice Roller',
        textAlign: .center,
        style: TextStyle(fontSize: 55, height: 1),
      ),
    ),
  );
}

@immutable
class _BottomSlot extends StatelessWidget {
  const _BottomSlot();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.read<Palette>();
    return Column(
      mainAxisAlignment: .end,
      children: [
        RoughButton(
          onTap: () => const GameLevelsRoute().go(context),
          child: const Text('Play'),
        ),
        const SizedBox(height: 10),
        RoughButton(
          onTap: () => const GameRulesRoute().push(context),
          child: const Text('Game Rules'),
        ),
        const SizedBox(height: 10),
        RoughButton(
          onTap: () => const GameSettingsRoute().go(context),
          child: const Text('Settings'),
        ),
        const SizedBox(height: 40),
        ValueListenableBuilder<bool>(
          valueListenable: settings.muted,
          builder: (context, muted, child) => RoughButton(
            onTap: settings.toggleMuted,
            fillColor: muted ? palette.backgroundMainSet.dark : palette.redPen,
            child: Icon(muted ? Icons.volume_off : Icons.volume_up, size: 30),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
