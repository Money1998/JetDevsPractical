import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetdevs/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: white,
      iconTheme: const IconThemeData(
        color: iconThemeColor,
      ),
      titleTextStyle: GoogleFonts.ibmPlexSans(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.normal),
    ),
    textTheme: const TextTheme(),
    colorScheme: const ColorScheme.light(
      primary: appBarColor,
      onPrimary: appBarColor,
      background: appBarColor,
    ).copyWith(background: appBarColor),
  );
}
