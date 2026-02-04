import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/models/game_score.dart';
import 'package:dice_roller/pages/game_home_screen.dart';
import 'package:dice_roller/pages/game_levels_screen.dart';
import 'package:dice_roller/pages/game_result_screen.dart';
import 'package:dice_roller/pages/game_rules_screen.dart';
import 'package:dice_roller/pages/game_session_screen.dart';
import 'package:dice_roller/pages/game_settings_screen.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/my_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'router.g.dart';

@TypedGoRoute<GameHomeRoute>(
  path: GameHomeRoute.path,
  routes: [
    TypedGoRoute<GameLevelsRoute>(
      path: GameLevelsRoute.path,
      routes: [
        TypedGoRoute<GameSessionRoute>(path: GameSessionRoute.path),
        TypedGoRoute<GameResultRoute>(path: GameResultRoute.path),
      ],
    ),
    TypedGoRoute<GameSettingsRoute>(path: GameSettingsRoute.path),
    TypedGoRoute<GameRulesRoute>(path: GameRulesRoute.path),
  ],
)
@immutable
class GameHomeRoute extends GoRouteData with $GameHomeRoute {
  const GameHomeRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GameHomeScreen();
  }
}

@immutable
class GameRulesRoute extends GoRouteData with $GameRulesRoute {
  const GameRulesRoute();

  static const path = 'game-rules-screen';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().background4,
      child: const GameRulesScreen(),
    );
  }
}

@immutable
class GameSettingsRoute extends GoRouteData with $GameSettingsRoute {
  const GameSettingsRoute();

  static const path = 'game-settings-screen';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().backgroundSettings,
      child: const GameSettingsScreen(),
    );
  }
}

@immutable
class GameLevelsRoute extends GoRouteData with $GameLevelsRoute {
  const GameLevelsRoute();

  static const path = 'game-levels-screen';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().backgroundLevelSelection,
      child: const GameLevelsScreen(),
    );
  }
}

@immutable
class GameSessionRoute extends GoRouteData with $GameSessionRoute {
  const GameSessionRoute({required this.level});

  final int level;

  static const path = 'game-session-screen/:level';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final gameLevel = gameLevels.singleWhere((e) => e.level == level);
    return buildTransition(
      color: context.read<Palette>().backgroundPlaySession,
      child: GameSessionScreen(level: gameLevel),
    );
  }
}

@immutable
class GameResultRoute extends GoRouteData with $GameResultRoute {
  const GameResultRoute();

  static const path = 'game-result-screen';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().background4,
      child: GameResultScreen(score: state.extra! as GameScore),
    );
  }
}
