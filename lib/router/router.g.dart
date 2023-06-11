// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $mainAppRoute,
    ];

RouteBase get $mainAppRoute => GoRouteData.$route(
      path: '/',
      factory: $MainAppRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'settings/:level',
          factory: $SettingsRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'gamerules/:level',
          factory: $GameRulesRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'play',
          factory: $PlayRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'session/:level',
              factory: $PlaySessionRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'won',
              factory: $WinGameRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MainAppRouteExtension on MainAppRoute {
  static MainAppRoute _fromState(GoRouterState state) => const MainAppRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute(
        level: int.parse(state.pathParameters['level']!),
      );

  String get location => GoRouteData.$location(
        '/settings/${Uri.encodeComponent(level.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GameRulesRouteExtension on GameRulesRoute {
  static GameRulesRoute _fromState(GoRouterState state) => GameRulesRoute(
        level: int.parse(state.pathParameters['level']!),
      );

  String get location => GoRouteData.$location(
        '/gamerules/${Uri.encodeComponent(level.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PlayRouteExtension on PlayRoute {
  static PlayRoute _fromState(GoRouterState state) => const PlayRoute();

  String get location => GoRouteData.$location(
        '/play',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PlaySessionRouteExtension on PlaySessionRoute {
  static PlaySessionRoute _fromState(GoRouterState state) => PlaySessionRoute(
        level: int.parse(state.pathParameters['level']!),
      );

  String get location => GoRouteData.$location(
        '/play/session/${Uri.encodeComponent(level.toString())}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WinGameRouteExtension on WinGameRoute {
  static WinGameRoute _fromState(GoRouterState state) => const WinGameRoute();

  String get location => GoRouteData.$location(
        '/play/won',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
