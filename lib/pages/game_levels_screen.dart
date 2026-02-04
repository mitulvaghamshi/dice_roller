import 'package:dice_roller/controllers/progress_controller.dart';
import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class GameLevelsScreen extends StatelessWidget {
  const GameLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.read<Palette>().backgroundLevelSelection,
    body: ResponsiveScreen(
      topSlot: const Text('Select level', style: TextStyle(fontSize: 50)),
      mainSlot: ListView.separated(
        padding: .symmetric(vertical: 16),
        itemCount: gameLevels.length,
        separatorBuilder: (_, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => _LevelListItem(index: index),
      ),
      bottomSlot: RoughButton(onTap: context.pop, child: const Text('Back')),
    ),
  );
}

@immutable
class _LevelListItem extends StatelessWidget {
  const _LevelListItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final level = gameLevels.elementAt(index);
    final progress = context.watch<ProgressController>();
    return RoughButton(
      onTap: () => GameSessionRoute(level: level.level).go(context),
      enabled: progress.highestLevel >= level.level - 1,
      fillColor: context.read<Palette>().backgroundSettings,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text('${index + 1}', style: const TextStyle(fontSize: 18)),
          Text('Level #${level.level}', style: const TextStyle(fontSize: 20)),
          Text(
            'Dices: ${level.dices} | Sides: ${level.sides}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
