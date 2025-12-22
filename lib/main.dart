import 'package:flutter/material.dart';
import 'theme.dart'; // Kept in lib/theme.dart
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CeLOE LMS',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Using theme from lib/theme.dart
      home: const SplashScreen(),
    );
  }
}
