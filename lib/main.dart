import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tukka_power_app/quiz.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures system bindings are initialized.

  // Lock the screen orientation to portrait.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const Quizz()); // Run the app after locking the orientation.
  });
}
