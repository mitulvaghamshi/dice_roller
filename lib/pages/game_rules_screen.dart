import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class GameRulesScreen extends StatefulWidget {
  const GameRulesScreen({super.key});

  @override
  State<GameRulesScreen> createState() => _GameRulesScreenState();
}

class _GameRulesScreenState extends State<GameRulesScreen> {
  final _ctrl = PageController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.read<Palette>().background4,
    body: ResponsiveScreen(
      topSlot: _TopSlot(onTap: context.pop),
      mainSlot: _MainSlot(controller: _ctrl),
      bottomSlot: _BottomSlot(controller: _ctrl, onTap: context.pop),
    ),
  );
}

@immutable
class _TopSlot extends StatelessWidget {
  const _TopSlot({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Align(
    alignment: .topRight,
    child: RoughButton(
      onTap: onTap,
      padding: const .all(8),
      child: Image.asset(
        'assets/imgs/cross.webp',
        semanticLabel: 'Close game rules',
        width: 30,
      ),
    ),
  );
}

@immutable
class _MainSlot extends StatelessWidget {
  const _MainSlot({required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: .center,
    children: [
      Image.asset(
        'assets/imgs/bar.webp',
        fit: .fill,
        height: View.of(context).physicalSize.height * 0.9,
      ),
      PageView(
        controller: controller,
        children: _rules.map((item) {
          return Center(
            child: Padding(
              padding: const .all(16),
              child: Text(
                item,
                style: const TextStyle(fontSize: 26, fontWeight: .bold),
              ),
            ),
          );
        }).toList(),
      ),
    ],
  );
}

@immutable
class _BottomSlot extends StatelessWidget {
  const _BottomSlot({required this.controller, required this.onTap});

  final PageController controller;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => RoughButton(
    onTap: () {
      if (controller.page == 5) return onTap();
      controller.nextPage(
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInBack,
      );
    },
    drawRectangle: true,
    child: RotatedBox(
      quarterTurns: 2,
      child: Image.asset('assets/imgs/back.webp'),
    ),
  );
}

const _rules = [
  '''
Rules:
The game is based on 5 winning patterns...
Match maximum patterns to collect respective
points associated with each pattern.''',
  '''
Pattern 1: (10 pts):
1. Get all same numbers.
2. Play with at least X number of sides.''',
  '''
Pattern 2: (15 pts):
1. Make any scrore that is a prime number
2. e.g. (3, 5, 7, 11, 13, so on).
3. And scrore at least 20 points or more.''',
  '''
Pattern 3: (5 pts):
1. Get more then half of dices each make score more then average.
2. Play with at least X number of dices.''',
  '''
Pattern 4: (8 pts):
1. Get all unique numbers.
2. Play with at least X number of dices.
3. Weight of sides over dices.''',
  '''
Pattern 5: (1 pt):
1. If you didn't match any of other criteria.''',
];
