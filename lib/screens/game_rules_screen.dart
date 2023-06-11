import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/responsive_screen.dart';
import 'package:dice_roller/widgets/rough_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class GameRulesScreen extends StatefulWidget {
  const GameRulesScreen({super.key, required this.level});

  final int level;

  @override
  State<GameRulesScreen> createState() => _GameRulesScreenState();
}

class _GameRulesScreenState extends State<GameRulesScreen> {
  late final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var palette = context.read<Palette>();
    return Scaffold(
      backgroundColor: palette.background4,
      body: ResponsiveScreen(
        topSlot: Align(
          alignment: Alignment.topRight,
          child: RoughButton(
            onTap: _onClose,
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/imgs/cross.webp',
              semanticLabel: 'Close game rules.',
              width: 30,
            ),
          ),
        ),
        bottomSlot: RoughButton(
          drawRectangle: true,
          onTap: () {
            if (_controller.page == 5) {
              _onClose();
            } else {
              _controller.nextPage(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInBack,
              );
            }
          },
          child: RotatedBox(
            quarterTurns: 2,
            child: Image.asset('assets/imgs/back.webp'),
          ),
        ),
        mainSlot: Stack(alignment: Alignment.center, children: [
          Image.asset(
            'assets/imgs/bar.webp',
            height: MediaQuery.of(context).size.height * 0.9,
            fit: BoxFit.fill,
          ),
          PageView(
            controller: _controller,
            children: _rules.map((item) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

extension on _GameRulesScreenState {
  void _onClose() {
    if (widget.level == -1) {
      context.pop();
    } else {
      PlaySessionRoute(level: widget.level).go(context);
    }
  }
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
