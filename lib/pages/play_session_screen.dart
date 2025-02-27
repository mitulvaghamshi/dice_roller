import 'dart:async';

import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/src/controllers/progress_controller.dart';
import 'package:dice_roller/src/controllers/settings_controller.dart';
import 'package:dice_roller/src/models/game_levels.dart';
import 'package:dice_roller/src/models/game_score.dart';
import 'package:dice_roller/src/models/game_state.dart';
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
  late final _anim = AnimationController(
    vsync: this,
    upperBound: 5,
    duration: const Duration(seconds: 3),
  )..addStatusListener(_onAnimComplete);

  final _startOfPlay = DateTime.now();

  bool _animCompleted = false;
  bool _isCelebrating = false;

  Future<void> _playerWon(Iterable<int> values) async {
    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(const Duration(seconds: 1));
    setState(() => _isCelebrating = true);
    if (!mounted) return;
    context.read<ProgressController>().setLevelReached(widget.level.level);

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(const Duration(seconds: 5));
    setState(() => _isCelebrating = false);

    if (!mounted) return;
    context.go(
      const WinGameRoute().location,
      extra: GameScore(
        diceValues: values,
        level: widget.level,
        duration: DateTime.now().difference(_startOfPlay),
      ),
    );
  }

  void _onAnimComplete(AnimationStatus status) {
    if (mounted && status == .completed) {
      setState(() => _animCompleted = true);
    }
  }

  @override
  void dispose() {
    _anim.removeStatusListener(_onAnimComplete);
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider(
    create: (_) => GameState(level: widget.level, onWin: _playerWon),
    child: IgnorePointer(
      ignoring: _isCelebrating,
      child: Scaffold(
        backgroundColor: context.read<Palette>().backgroundPlaySession,
        body: Stack(
          children: [
            ResponsiveScreen(
              topSlot: const _TopSlot(),
              mainSlot: _MainSlot(
                isComplete: _animCompleted && !_isCelebrating,
                level: widget.level,
                animation: _anim,
              ),
              bottomSlot: _BottomSlot(animation: _anim),
            ),
            Positioned.fill(
              child: Visibility(
                visible: _isCelebrating,
                child: ConfettiView(isStopped: !_isCelebrating),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

@immutable
class _TopSlot extends StatelessWidget {
  const _TopSlot();

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: .end,
    mainAxisSize: .min,
    children: [
      RoughButton(
        onTap: () => const PlayRoute().go(context),
        padding: const .all(8),
        child: Image.asset(
          'assets/imgs/cross.webp',
          semanticLabel: 'Close session',
          width: 30,
        ),
      ),
      RoughButton(
        onTap: () => const GameRulesRoute().push(context),
        padding: const .all(8),
        child: Image.asset(
          'assets/imgs/box.webp',
          semanticLabel: 'View game rules',
          width: 30,
        ),
      ),
      RoughButton(
        onTap: () => const SettingsRoute().push(context),
        padding: const .all(8),
        child: Image.asset(
          'assets/imgs/settings.webp',
          semanticLabel: 'Settings',
          width: 30,
        ),
      ),
    ],
  );
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot({
    required this.isComplete,
    required this.level,
    required this.animation,
  });

  final bool isComplete;
  final GameLevel level;
  final AnimationController animation;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Wrap(
        spacing: 10,
        children: [
          Text(
            'Player: ${context.read<SettingsController>().playerName.value}',
            style: const TextStyle(fontSize: 22),
          ),
          Text(
            'Dices: ${level.dices} | Sides: ${level.sides}',
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Consumer<GameState>(
        builder: (_, state, child) {
          if (isComplete && state.showResults) state.showWinScreen();
          return LayoutBuilder(
            builder: (_, constraints) => Wrap(
              alignment: .spaceAround,
              children: .generate(level.dices, (index) {
                return DiceWidget(
                  animation: animation,
                  width: (constraints.biggest.width ~/ 3.5).toDouble(),
                  sidesPerDice: state.level.sides,
                  diceValue: state.getDiceValueFor(index + 1),
                  onEnd: (value) => state.setDiceValueFor(index + 1, value),
                );
              }),
            ),
          );
        },
      ),
    ],
  );
}

@immutable
class _BottomSlot extends StatelessWidget {
  const _BottomSlot({required this.animation});

  final AnimationController animation;

  @override
  Widget build(BuildContext context) => Consumer<GameState>(
    builder: (_, state, child) => RoughButton(
      onTap: () {
        animation.forward(from: 0);
        state.reset();
      },
      padding: .zero,
      drawRectangle: true,
      child: const Text(
        'Roll',
        style: TextStyle(fontSize: 30, fontFamily: 'Permanent Marker'),
      ),
    ),
  );
}
