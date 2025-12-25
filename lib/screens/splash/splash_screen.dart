import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../auth/login_screen.dart';
import '../main_screen.dart';
import '../../data/user_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () async {
      if (mounted) {
        // Check if user is logged in
        if (UserData.isLoggedIn) {
          // Navigate to MainScreen if user is already logged in
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          // Navigate to LoginScreen if user is not logged in
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF001F54), // Darker Navy Blue
              kPrimaryColor, // Standard Dark Blue (0xFF00008B)
              Color(0xFF001F54), // Darker Navy Blue
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            // Logo / Icon
            // Using a stylized container to mimic a logo if image is missing
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.menu_book_rounded, // Specific Book Icon
                size: 80,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // "CeLOE" Text
            const Text(
              "CeLOE",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
                fontFamily: 'Poppins', // Ensure font is applied
              ),
            ),

            // Subtitle
            const Text(
              "Learning Management System",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),

            const Spacer(),

            // Loading Indicator
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),

            const SizedBox(height: 40),

            // Footer text
            const Text(
              "v1.0.0",
              style: TextStyle(color: Colors.white30, fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
