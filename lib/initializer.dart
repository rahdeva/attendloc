import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Initializer {
  static Future<void> init() async {
    try {
      _initScreenPreference();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (err) {
      rethrow;
    }
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
