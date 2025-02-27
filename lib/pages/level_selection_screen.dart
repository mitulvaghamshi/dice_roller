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
  Widget build(BuildContext context) {
    var progress = context.watch<ProgressController>();
    var palette = context.read<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        topSlot: const Text('Select level', style: TextStyle(fontSize: 30)),
        mainSlot: ListView.separated(
          itemCount: gameLevels.length,
          separatorBuilder: (_, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            var level = gameLevels.elementAt(index);
            return RoughButton(
              onTap: () => PlaySessionRoute(level: level.level).go(context),
              enabled: progress.highestLevelReached >= level.level - 1,
              fillColor: palette.backgroundSettings,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${level.level}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text('Level #${level.level}'),
                  Text('Dices: ${level.dices} | Sides: ${level.sides}'),
                ],
              ),
            );
          },
        ),
        bottomSlot: RoughButton(onTap: context.pop, child: const Text('Back')),
      ),
    );
  }
}
