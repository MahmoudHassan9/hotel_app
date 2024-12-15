import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'firebase_options.dart';
import 'my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}
