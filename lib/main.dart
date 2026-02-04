import 'package:dice_roller/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(.edgeToEdge);

  runApp(MainApp.inMemory());
}
