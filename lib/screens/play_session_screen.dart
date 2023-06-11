import 'dart:async';

import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/models/game_state.dart';
import 'package:dice_roller/models/game_score.dart';
import 'package:dice_roller/persistence/progress_controller.dart';
import 'package:dice_roller/persistence/settings_controller.dart';
import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/confetti_view.dart';
import 'package:dice_roller/widgets/dice_widget.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class PlaySessionScreen extends StatefulWidget {
  const PlaySessionScreen({super.key, required this.level});

  final GameLevel level;

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    upperBound: 5,
    duration: const Duration(seconds: 3),
  )..addStatusListener(_onAnimationEnd);

  late final DateTime _startOfPlay = DateTime.now();

  bool _showResults = false;
  bool _isCelebrating = false;

  void _onAnimationEnd(status) {
    if (status == AnimationStatus.completed && mounted) _showResults = true;
  }

  Future<void> _playerWon(diceValues) async {
    var score = GameScore(
      diceValues: diceValues,
      level: widget.level,
      duration: DateTime.now().difference(_startOfPlay),
    );

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(const Duration(milliseconds: 500));

    setState(() => _isCelebrating = true);

    if (!mounted) return;

    context.read<ProgressController>().setLevelReached(widget.level.number);

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    context.go(const WinGameRoute().location, extra: score);
  }

  @override
  void dispose() {
    _animation
      ..removeStatusListener(_onAnimationEnd)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var palette = context.read<Palette>();
    var settings = context.read<SettingsController>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameState(
            level: widget.level,
            onWin: _playerWon,
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _isCelebrating,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: Stack(children: [
            ResponsiveScreen(
              topSlot: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoughButton(
                    onTap: () => const PlayRoute().go(context),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/imgs/cross.webp',
                      semanticLabel: 'Close session',
                      width: 30,
                    ),
                  ),
                  RoughButton(
                    onTap: () => GameRulesRoute(
                      // Pass the current level number,
                      // will continue on closing rules screen.
                      level: widget.level.number,
                    ).go(context),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/imgs/box.webp',
                      semanticLabel: 'View game rules',
                      width: 30,
                    ),
                  ),
                  RoughButton(
                    onTap: () => SettingsRoute(
                      // Pass the current level number,
                      // will continue on closing rules screen.
                      level: widget.level.number,
                    ).go(context),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/imgs/settings.webp',
                      semanticLabel: 'Settings',
                      width: 30,
                    ),
                  ),
                ],
              ),
              bottomSlot: Consumer<GameState>(
                builder: (_, state, child) => RoughButton(
                  onTap: () {
                    state.reset();
                    _animation.forward(from: 0);
                  },
                  drawRectangle: true,
                  padding: EdgeInsets.zero,
                  child: const Text(
                    'Roll',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Permanent Marker',
                    ),
                  ),
                ),
              ),
              mainSlot: Column(children: [
                Wrap(spacing: 10, children: [
                  Text(
                    'Player: ${settings.playerName.value}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  Text(
                    'Dices: ${widget.level.dices} |'
                    ' Sides: ${widget.level.sides}',
                    style: const TextStyle(fontSize: 22),
                  ),
                ]),
                const SizedBox(height: 20),
                Consumer<GameState>(builder: (_, state, child) {
                  if (_showResults && !_isCelebrating && state.showResults) {
                    state.showWiningScreen();
                  }
                  return LayoutBuilder(builder: (_, constraints) {
                    var width = constraints.biggest.width;
                    var diceWidth = width ~/ 3.5;
                    return Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: List.generate(widget.level.dices, (index) {
                        return DiceWidget(
                          animation: _animation,
                          width: diceWidth.toDouble(),
                          sidesPerDice: state.level.sides,
                          diceValue: state.getDiceValueFor(index + 1),
                          onEnd: (value) =>
                              state.setDiceValueFor(index + 1, value),
                        );
                      }),
                    );
                  });
                }),
              ]),
            ),
            Positioned.fill(
              child: Visibility(
                visible: _isCelebrating,
                child: ConfettiView(isStopped: !_isCelebrating),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
