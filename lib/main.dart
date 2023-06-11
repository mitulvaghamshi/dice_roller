import 'package:dice_roller/app.dart';
import 'package:dice_roller/persistence/progress/local_storage_progress_persistence.dart';
import 'package:dice_roller/persistence/settings/local_storage_settings_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(MainApp(
    settings: LocalStorageSettingsPersistence(),
    progress: LocalStorageProgressPersistence(),
  ));
}
