import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/src/controllers/progress_controller.dart';
import 'package:dice_roller/src/models/game_levels.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.read<Palette>().backgroundLevelSelection,
    body: ResponsiveScreen(
      topSlot: const Text('Select level', style: TextStyle(fontSize: 30)),
      mainSlot: ListView.separated(
        itemCount: gameLevels.length,
        separatorBuilder: (_, index) => const SizedBox(height: 5),
        itemBuilder: (context, index) => _LevelItem(index: index),
      ),
      bottomSlot: RoughButton(onTap: context.pop, child: const Text('Back')),
    ),
  );
}

@immutable
class _LevelItem extends StatelessWidget {
  const _LevelItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final level = gameLevels.elementAt(index);
    final progress = context.watch<ProgressController>();
    return RoughButton(
      onTap: () => PlaySessionRoute(level: level.level).go(context),
      enabled: progress.highestLevelReached >= level.level - 1,
      fillColor: context.read<Palette>().backgroundSettings,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('${level.level}', style: const TextStyle(fontSize: 22)),
          Text('Level #${level.level}'),
          Text('Dices: ${level.dices} | Sides: ${level.sides}'),
        ],
      ),
    );
  }
}
