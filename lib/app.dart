import 'package:dice_roller/router/router.dart';
import 'package:dice_roller/src/controllers/progress_controller.dart';
import 'package:dice_roller/src/controllers/settings_controller.dart';
import 'package:dice_roller/src/services/progress_impl/memory_progress_persistence.dart';
import 'package:dice_roller/src/services/progress_service.dart';
import 'package:dice_roller/src/services/settings_impl/memory_settings_persistence.dart';
import 'package:dice_roller/src/services/settings_service.dart';
import 'package:dice_roller/utils/messenger.dart';
import 'package:dice_roller/utils/palette.dart';
import 'package:dice_roller/widgets/app_lifecycle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

@immutable
class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.settings, required this.progress});

  MainApp.inMemory({super.key})
    : settings = MemorySettingsPersistence(),
      progress = MemoryProgressPersistence();

  final SettingsService settings;
  final ProgressService progress;

  static final _router = GoRouter(routes: $appRoutes);

  @override
  Widget build(BuildContext context) => AppLifecycleObserver(
    child: MultiProvider(
      providers: [
        Provider(create: (_) => Palette()),
        Provider(create: (_) => SettingsController(settings)..load()),
        ChangeNotifierProvider(
          create: (_) => ProgressController(progress)..load(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final palette = context.read<Palette>();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Dice Game',
            routerConfig: _router,
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: .from(
              useMaterial3: true,
              colorScheme: .fromSeed(
                seedColor: palette.darkPen,
                surface: palette.backgroundMainSet.dark,
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(
                  color: palette.ink,
                  fontFamily: 'Permanent Marker',
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
