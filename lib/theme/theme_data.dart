import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phonetic_symbol_app/theme/colors.dart';

ThemeData getThemeData(ColorScheme colorScheme, Brightness currentTheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    fontFamily: GoogleFonts.inter().fontFamily,
    // fontFamily: GoogleFonts.playwriteDeSas().fontFamily,
    // fontFamily: GoogleFonts.pixelifySans().fontFamily,
    // fontFamily: GoogleFonts.robotoSlab().fontFamily,
    textTheme: TextTheme(),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   type: BottomNavigationBarType.fixed,
    // ),
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
