import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonetic_symbol_app/theme/colors.dart';

ThemeData getThemeData(ColorScheme colorScheme, Brightness currentTheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: TextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
    ),
    extensions: [
      PhoneticColors(
        currentTheme == Brightness.dark
            ? darkPhoneticColors
            : lightPhoneticColors,
      ),
    ],
  );
}
