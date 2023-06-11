import 'package:dice_roller/persistence/progress/progress_persistence.dart';
import 'package:dice_roller/persistence/progress_controller.dart';
import 'package:dice_roller/persistence/settings/settings_persistence.dart';
import 'package:dice_roller/persistence/settings_controller.dart';
import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/utils/snack_bar.dart';
import 'package:dice_roller/widgets/app_lifecycle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.settings, required this.progress});

  final SettingsPersistence settings;
  final ProgressPersistence progress;

  static final _router = GoRouter(routes: $appRoutes);

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return ProgressController(progress)..getFromStore();
          }),
          Provider<SettingsController>(create: (_) {
            return SettingsController(persistence: settings)..loadFromStore();
          }),
          Provider(create: (_) => Palette()),
        ],
        child: Builder(builder: (context) {
          final palette = context.read<Palette>();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'The Dice Game',
            routerConfig: _router,
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: ThemeData.from(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: palette.darkPen,
                background: palette.backgroundMain,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  color: palette.ink,
                  fontFamily: 'Permanent Marker',
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
