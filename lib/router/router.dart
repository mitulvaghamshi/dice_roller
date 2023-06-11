import 'package:dice_roller/models/game_levels.dart';
import 'package:dice_roller/models/game_score.dart';
import 'package:dice_roller/screens/game_rules_screen.dart';
import 'package:dice_roller/screens/level_selection_screen.dart';
import 'package:dice_roller/screens/main_menu_screen.dart';
import 'package:dice_roller/screens/play_session_screen.dart';
import 'package:dice_roller/screens/settings_screen.dart';
import 'package:dice_roller/screens/win_game_screen.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/my_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'router.g.dart';

@TypedGoRoute<MainAppRoute>(path: '/', routes: <TypedGoRoute<GoRouteData>>[
  TypedGoRoute<SettingsRoute>(path: 'settings/:level'),
  TypedGoRoute<GameRulesRoute>(path: 'gamerules/:level'),
  TypedGoRoute<PlayRoute>(path: 'play', routes: [
    TypedGoRoute<PlaySessionRoute>(path: 'session/:level'),
    TypedGoRoute<WinGameRoute>(path: 'won'),
  ]),
])
@immutable
class MainAppRoute extends GoRouteData {
  const MainAppRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainMenuScreen(key: Key('main-menu-screen'));
  }
}

@immutable
class GameRulesRoute extends GoRouteData {
  const GameRulesRoute({required this.level});

  final int level;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().background4,
      child: GameRulesScreen(
        key: const Key('game-rules-screen'),
        level: level,
      ),
    );
  }
}

@immutable
class SettingsRoute extends GoRouteData {
  const SettingsRoute({required this.level});

  final int level;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().backgroundSettings,
      child: SettingsScreen(key: const Key('settings-screen'), level: level),
    );
  }
}

@immutable
class PlayRoute extends GoRouteData {
  const PlayRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().backgroundLevelSelection,
      child: const LevelSelectionScreen(key: Key('level-selection-screen')),
    );
  }
}

@immutable
class PlaySessionRoute extends GoRouteData {
  const PlaySessionRoute({required this.level});

  final int level;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().backgroundPlaySession,
      child: PlaySessionScreen(
        key: const Key('play-session-screen'),
        level: gameLevels.singleWhere((e) => e.number == level),
      ),
    );
  }
}

@immutable
class WinGameRoute extends GoRouteData {
  const WinGameRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().background4,
      child: WinGameScreen(
        key: const Key('win-game-screen'),
        score: state.extra! as GameScore,
      ),
    );
  }
}
