import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color Constants
const Color kPrimaryColor = Color(0xFF00008B); // Dark Blue (CeLOE Brand)
const Color kAccentColor = Color(0xFF00C853); // Green
const Color kTextColor = Color(0xFF212121); // Dark Gray/Black
const Color kBackgroundColor = Color(0xFFFFFFFF); // White

// Standard TextStyles
TextStyle get kHeaderStyle => GoogleFonts.poppins(
  color: kTextColor,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

TextStyle get kBodyStyle => GoogleFonts.poppins(
  color: kTextColor,
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

// Theme Data
final ThemeData appTheme = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: kPrimaryColor,
    secondary: kAccentColor,
  ),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: kTextColor,
    displayColor: kTextColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
);
