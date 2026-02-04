import 'package:dice_roller/app.dart';
import 'package:dice_roller/services/progress_impl/local_storage_progress_persistence.dart';
import 'package:dice_roller/services/settings_impl/local_storage_settings_persistence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(.edgeToEdge);

  const settings = LocalStorageSettingsPersistence();
  const progress = LocalStorageProgressPersistence();

  runApp(const MainApp(settings: settings, progress: progress));
}
