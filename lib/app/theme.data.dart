import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
      ).fontFamily,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 78, 168),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
      ).fontFamily,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 42, 42, 42),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 78, 168),
        ),
      ),
    );
  }
}
