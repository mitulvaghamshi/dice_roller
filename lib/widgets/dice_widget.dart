import 'dart:math' as math;

import 'package:flutter/material.dart';

@immutable
class DiceWidget extends StatefulWidget {
  const DiceWidget({
    super.key,
    required this.animation,
    required this.diceValue,
    required this.width,
    required this.sidesPerDice,
    required this.onEnd,
  });

  final Animation<double> animation;
  final double width;
  final int diceValue;
  final int sidesPerDice;
  final ValueChanged<int> onEnd;

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  void _onComplete(AnimationStatus status) {
    if (status == .completed) {
      widget.onEnd(math.Random().nextInt(widget.sidesPerDice) + 1);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_onComplete);
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_onComplete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RotationTransition(
    turns: widget.animation,
    child: Image.asset(
      'assets/dices/dice_${widget.diceValue}.webp',
      fit: .contain,
      width: widget.width,
      semanticLabel: 'Dice with ${widget.diceValue} numbers.',
    ),
  );
}
