import 'package:dice_roller/app.dart';
import 'package:dice_roller/src/services/progress_impl/local_storage_progress_persistence.dart';
import 'package:dice_roller/src/services/settings_impl/local_storage_settings_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(MainApp(
    settings: LocalStorageSettingsPersistence(),
    progress: LocalStorageProgressPersistence(),
  ));
}
