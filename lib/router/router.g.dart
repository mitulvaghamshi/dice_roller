// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$menuRoute];

RouteBase get $menuRoute => GoRouteData.$route(
  path: '/',
  factory: $MenuRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'settings', factory: $SettingsRoute._fromState),
    GoRouteData.$route(path: 'gamerules', factory: $GameRulesRoute._fromState),
    GoRouteData.$route(
      path: 'play',
      factory: $PlayRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'session/:level',
          factory: $PlaySessionRoute._fromState,
        ),
        GoRouteData.$route(path: 'won', factory: $WinGameRoute._fromState),
      ],
    ),
  ],
);

mixin $MenuRoute on GoRouteData {
  static MenuRoute _fromState(GoRouterState state) => const MenuRoute();

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

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

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
  String get location => GoRouteData.$location('/gamerules');

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

mixin $PlayRoute on GoRouteData {
  static PlayRoute _fromState(GoRouterState state) => const PlayRoute();

  @override
  String get location => GoRouteData.$location('/play');

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

mixin $PlaySessionRoute on GoRouteData {
  static PlaySessionRoute _fromState(GoRouterState state) =>
      PlaySessionRoute(level: int.parse(state.pathParameters['level']!));

  PlaySessionRoute get _self => this as PlaySessionRoute;

  @override
  String get location => GoRouteData.$location(
    '/play/session/${Uri.encodeComponent(_self.level.toString())}',
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

mixin $WinGameRoute on GoRouteData {
  static WinGameRoute _fromState(GoRouterState state) => const WinGameRoute();

  @override
  String get location => GoRouteData.$location('/play/won');

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
