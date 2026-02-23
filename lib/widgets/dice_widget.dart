import 'package:flutter/material.dart';

@immutable
class DiceWidget extends StatefulWidget {
  const DiceWidget({
    super.key,
    required this.animation,
    required this.diceValue,
    required this.onComplete,
  });

  final Animation<double> animation;
  final int diceValue;
  final VoidCallback onComplete;

  @override
  State<DiceWidget> createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  void _onComplete(AnimationStatus status) {
    if (status == .completed) widget.onComplete();
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
      width: MediaQuery.sizeOf(context).shortestSide / 3.5,
      semanticLabel: 'Dice with ${widget.diceValue} numbers.',
    ),
  );
}
