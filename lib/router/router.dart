import 'package:dice_roller/pages/game_rules_screen.dart';
import 'package:dice_roller/pages/level_selection_screen.dart';
import 'package:dice_roller/pages/menu_screen.dart';
import 'package:dice_roller/pages/play_session_screen.dart';
import 'package:dice_roller/pages/settings_screen.dart';
import 'package:dice_roller/pages/win_game_screen.dart';
import 'package:dice_roller/src/models/game_levels.dart';
import 'package:dice_roller/src/models/game_score.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/my_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

part 'router.g.dart';

@TypedGoRoute<MenuRoute>(path: '/', routes: <TypedGoRoute<GoRouteData>>[
  TypedGoRoute<SettingsRoute>(path: 'settings/:level'),
  TypedGoRoute<GameRulesRoute>(path: 'gamerules/:level'),
  TypedGoRoute<PlayRoute>(path: 'play', routes: [
    TypedGoRoute<PlaySessionRoute>(path: 'session/:level'),
    TypedGoRoute<WinGameRoute>(path: 'won'),
  ]),
])
@immutable
class MenuRoute extends GoRouteData {
  const MenuRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MenuScreen();
}

@immutable
class GameRulesRoute extends GoRouteData {
  const GameRulesRoute({required this.level});

  final int level;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return buildTransition(
      color: context.read<Palette>().background4,
      child: GameRulesScreen(level: level),
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
      child: SettingsScreen(level: level),
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
      child: const LevelSelectionScreen(),
    );
  }
}

@immutable
class PlaySessionRoute extends GoRouteData {
  const PlaySessionRoute({required this.level});

  final int level;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    var gameLevel = gameLevels.singleWhere((e) => e.level == level);
    return buildTransition(
      color: context.read<Palette>().backgroundPlaySession,
      child: PlaySessionScreen(level: gameLevel),
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
      child: WinGameScreen(score: state.extra! as GameScore),
    );
  }
}
