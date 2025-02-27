import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/src/models/game_score.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class WinGameScreen extends StatelessWidget {
  const WinGameScreen({super.key, required this.score});

  final GameScore score;

  @override
  Widget build(BuildContext context) {
    var palette = context.read<Palette>();
    const textStyle = TextStyle(fontSize: 20);

    return Scaffold(
      backgroundColor: palette.background4,
      body: ResponsiveScreen(
        topSlot: const Text('Game Result', style: TextStyle(fontSize: 50)),
        mainSlot: ListView(children: [
          Divider(thickness: 2, color: palette.pen),
          Text('Score: ${score.finalScore}', style: textStyle),
          Divider(thickness: 2, color: palette.pen),
          Text('Time: ${score.formattedTime}', style: textStyle),
          Divider(thickness: 2, color: palette.pen),
          Text(score.descAllRollValues, style: textStyle),
          Text(score.descSumAndAverage, style: textStyle),
          Divider(thickness: 2, color: palette.pen),
          ...score.results.map((e) => Text(e.reason, style: textStyle)),
          Divider(thickness: 2, color: palette.pen),
          Text(score.descBonusFactor, style: textStyle),
          Divider(thickness: 2, color: palette.pen),
          Text(score.descFinalScore, style: textStyle),
          Divider(thickness: 2, color: palette.pen),
        ]),
        bottomSlot: RoughButton(
          onTap: () => const PlayRoute().go(context),
          child: const Text('Continue', style: textStyle),
        ),
      ),
    );
  }
}
