import 'package:dice_roller/models/game_score.dart';
import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@immutable
class GameResultScreen extends StatelessWidget {
  const GameResultScreen({super.key, required this.score});

  final GameScore score;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.read<Palette>().background4,
    body: ResponsiveScreen(
      topSlot: const Text('Game Result', style: TextStyle(fontSize: 50)),
      mainSlot: _MainSlot(score: score),
      bottomSlot: RoughButton(
        onTap: () => const GameLevelsRoute().go(context),
        child: const Text('Continue', style: TextStyle(fontSize: 20)),
      ),
    ),
  );
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot({required this.score});

  final GameScore score;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    final textStyle = DefaultTextStyle.of(context).style.copyWith(fontSize: 20);
    return ListView(
      children: [
        Divider(thickness: 2, color: palette.pen),
        ListTile(title: Text('Score: ${score.finalScore}', style: textStyle)),
        Divider(thickness: 2, color: palette.pen),
        ListTile(title: Text('Time: ${score.formattedTime}', style: textStyle)),
        Divider(thickness: 2, color: palette.pen),
        ListTile(title: Text(score.descAllRollValues, style: textStyle)),
        ListTile(title: Text(score.descSumAndAverage, style: textStyle)),
        Divider(thickness: 2, color: palette.pen),
        for (var result in score.results)
          ListTile(
            leading: Text(result.points.toString(), style: textStyle),
            title: Text(result.result, style: textStyle),
            subtitle: Text(result.reason, style: textStyle),
          ),
        Divider(thickness: 2, color: palette.pen),
        ListTile(title: Text(score.descBonusFactor, style: textStyle)),
        Divider(thickness: 2, color: palette.pen),
        ListTile(title: Text(score.descFinalScore, style: textStyle)),
        Divider(thickness: 2, color: palette.pen),
      ],
    );
  }
}
