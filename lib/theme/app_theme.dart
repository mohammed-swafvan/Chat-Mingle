import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.rubik(color: Colors.black),
      headlineMedium: GoogleFonts.rubik(color: Colors.black),
      headlineSmall: GoogleFonts.rubik(color: Colors.white),
      displayMedium: GoogleFonts.rubik(color: Colors.black),
      displaySmall: GoogleFonts.rubik(color: Colors.black),
      titleMedium: GoogleFonts.rubik(color: const Color(0xFFbbb0ff)),
      labelLarge: GoogleFonts.rubik(color: Colors.black),
      labelMedium: GoogleFonts.rubik(color: Colors.black),
      bodyLarge: GoogleFonts.rubik(color: Colors.white),
    ),
  );

  static final darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.rubik(color: Colors.white),
      headlineMedium: GoogleFonts.rubik(color: Colors.white),
      headlineSmall: GoogleFonts.rubik(color: Colors.white),
      displayMedium: GoogleFonts.rubik(color: Colors.white),
      displaySmall: GoogleFonts.rubik(color: Colors.white),
      titleMedium: GoogleFonts.rubik(color: const Color(0xFFbbb0ff)),
      labelLarge: GoogleFonts.rubik(color: Colors.white),
      labelMedium: GoogleFonts.rubik(color: Colors.white),
      bodyLarge: GoogleFonts.rubik(color: Colors.white),
    ),
  );
}
