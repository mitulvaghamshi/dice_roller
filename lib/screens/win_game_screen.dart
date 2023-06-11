import 'package:dice_roller/models/game_score.dart';
import 'package:dice_roller/router/router.dart';
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
    var spacer10 = Divider(thickness: 2, color: palette.pen);
    const testStyle = TextStyle(fontSize: 20);

    return Scaffold(
      backgroundColor: palette.background4,
      body: ResponsiveScreen(
        topSlot: const Text('Game Result', style: TextStyle(fontSize: 50)),
        mainSlot: ListView(children: [
          spacer10,
          Text('Score: ${score.finalScore}', style: testStyle),
          spacer10,
          Text('Time: ${score.formattedTime}', style: testStyle),
          spacer10,
          Text(score.descAllRollValues, style: testStyle),
          Text(score.descSumAndAverage, style: testStyle),
          spacer10,
          ...score.results.map((e) => Text(e.reason, style: testStyle)),
          spacer10,
          Text(score.descBonusFactor, style: testStyle),
          spacer10,
          Text(score.descFinalScore, style: testStyle),
          spacer10,
        ]),
        bottomSlot: RoughButton(
          onTap: () => const PlayRoute().go(context),
          child: const Text('Continue', style: testStyle),
        ),
      ),
    );
  }
}
