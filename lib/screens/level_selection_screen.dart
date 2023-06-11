import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/persistence/progress_controller.dart';
import 'package:dice_roller/router/router.dart';
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
    var palette = context.read<Palette>();
    var progress = context.watch<ProgressController>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        topSlot: const Text('Select level', style: TextStyle(fontSize: 30)),
        mainSlot: ListView.separated(
          itemCount: gameLevels.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 5);
          },
          itemBuilder: (context, index) {
            var level = gameLevels.elementAt(index);
            return RoughButton(
              enabled: progress.highestLevelReached >= level.number - 1,
              fillColor: palette.backgroundSettings,
              onTap: () => PlaySessionRoute(level: level.number).go(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    level.number.toString(),
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text('Level #${level.number}'),
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
