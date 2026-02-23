import 'dart:async';
import 'dart:math' as math;

import 'package:dice_roller/controllers/progress_controller.dart';
import 'package:dice_roller/controllers/settings_controller.dart';
import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/models/game_score.dart';
import 'package:dice_roller/models/game_state.dart';
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
class GameSessionScreen extends StatefulWidget {
  const GameSessionScreen({super.key, required this.level});

  final GameLevel level;

  @override
  State<GameSessionScreen> createState() => _GameSessionScreenState();
}

class _GameSessionScreenState extends State<GameSessionScreen>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    upperBound: 5,
    duration: const Duration(seconds: 3),
  )..addStatusListener(_onAnimComplete);

  final _startOfPlay = DateTime.now();

  bool _animCompleted = false;
  bool _isCelebrating = false;

  Future<void> _levelComplete(Iterable<int> values) async {
    setState(() => _isCelebrating = true);
    await Future.delayed(const .new(seconds: 3));
    setState(() => _isCelebrating = false);

    if (!mounted) return;
    context.read<ProgressController>().highestLevel = widget.level.level;
    context.go(
      const GameResultRoute().location,
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
    _animation.removeStatusListener(_onAnimComplete);
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Provider<GameState>(
    create: (_) => .new(level: widget.level, onComplete: _levelComplete),
    builder: (context, child) => IgnorePointer(
      ignoring: _isCelebrating,
      child: Scaffold(
        backgroundColor: context.read<Palette>().backgroundPlaySession,
        body: Stack(
          children: [
            ResponsiveScreen(
              topSlot: const _TopSlot(),
              mainSlot: _MainSlot(
                animation: _animation,
                isComplete: _animCompleted && !_isCelebrating,
              ),
              bottomSlot: _BottomSlot(
                onTap: () {
                  context.read<GameState>().reset();
                  _animation.forward(from: 0);
                },
              ),
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
        onTap: () => const GameLevelsRoute().go(context),
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
        onTap: () => const GameSettingsRoute().push(context),
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
class _BottomSlot extends StatelessWidget {
  const _BottomSlot({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => RoughButton(
    onTap: onTap,
    padding: .zero,
    draw: true,
    child: Text(
      'ROLL',
      style: DefaultTextStyle.of(
        context,
      ).style.copyWith(fontSize: 64, letterSpacing: 8),
    ),
  );
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot({required this.animation, required this.isComplete});

  final AnimationController animation;
  final bool isComplete;

  @override
  Widget build(BuildContext context) => Consumer<GameState>(
    builder: (_, state, child) {
      if (isComplete && state.showResults) state.showResultScreen();
      return Column(
        children: [
          ListTile(
            title: Text(
              'Hello, ${context.read<SettingsController>().player.value}',
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 32),
            ),
            subtitle: Text(
              'Dices: ${state.level.dices} | Sides: ${state.level.sides}',
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: .spaceAround,
            children: .generate(state.level.dices, (index) {
              return DiceWidget(
                animation: animation,
                diceValue: state.getDiceValueFor(index + 1),
                onComplete: () => state.setDiceValueFor(
                  index + 1,
                  math.Random().nextInt(state.level.sides) + 1,
                ),
              );
            }),
          ),
        ],
      );
    },
  );
}
