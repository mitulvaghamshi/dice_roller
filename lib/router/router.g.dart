// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$gameHomeRoute];

RouteBase get $gameHomeRoute => GoRouteData.$route(
  path: '/',
  factory: $GameHomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'game-levels-screen',
      factory: $GameLevelsRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'game-session-screen/:level',
          factory: $GameSessionRoute._fromState,
        ),
        GoRouteData.$route(
          path: 'game-result-screen',
          factory: $GameResultRoute._fromState,
        ),
      ],
    ),
    GoRouteData.$route(
      path: 'game-settings-screen',
      factory: $GameSettingsRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'game-rules-screen',
      factory: $GameRulesRoute._fromState,
    ),
  ],
);

mixin $GameHomeRoute on GoRouteData {
  static GameHomeRoute _fromState(GoRouterState state) => const GameHomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GameLevelsRoute on GoRouteData {
  static GameLevelsRoute _fromState(GoRouterState state) =>
      const GameLevelsRoute();

  @override
  String get location => GoRouteData.$location('/game-levels-screen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GameSessionRoute on GoRouteData {
  static GameSessionRoute _fromState(GoRouterState state) =>
      GameSessionRoute(level: int.parse(state.pathParameters['level']!));

  GameSessionRoute get _self => this as GameSessionRoute;

  @override
  String get location => GoRouteData.$location(
    '/game-levels-screen/game-session-screen/${Uri.encodeComponent(_self.level.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GameResultRoute on GoRouteData {
  static GameResultRoute _fromState(GoRouterState state) =>
      const GameResultRoute();

  @override
  String get location =>
      GoRouteData.$location('/game-levels-screen/game-result-screen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GameSettingsRoute on GoRouteData {
  static GameSettingsRoute _fromState(GoRouterState state) =>
      const GameSettingsRoute();

  @override
  String get location => GoRouteData.$location('/game-settings-screen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $GameRulesRoute on GoRouteData {
  static GameRulesRoute _fromState(GoRouterState state) =>
      const GameRulesRoute();

  @override
  String get location => GoRouteData.$location('/game-rules-screen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
