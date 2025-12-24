import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData celoeTheme = ThemeData(
  primaryColor: const Color(0xFF00008B), // Dark Blue
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.poppinsTextTheme(), // Using Poppins as requested
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF800000), // Maroon
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xFF00008B),
    secondary: const Color(0xFF800000),
  ),
);
