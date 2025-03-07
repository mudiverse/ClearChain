import 'package:flutter/material.dart';
import 'pages/reportPage.dart';
import 'pages/splash_screen.dart';
import 'themes/light_mode.dart';
import 'pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:lightmode,
      home:  SplashScreen(),
    );
  }
}

