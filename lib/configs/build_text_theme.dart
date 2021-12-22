import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photodatabase/configs/colors.dart';
import 'package:photodatabase/methods/layout.dart';

ThemeData buildTheme() {
  final base = ThemeData.dark();
  return ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: PhotoDatabaseColors.primaryBackground,
      elevation: 0,
    ),
    scaffoldBackgroundColor: PhotoDatabaseColors.primaryBackground,
    primaryColor: PhotoDatabaseColors.primaryBackground,
    focusColor: PhotoDatabaseColors.primaryBackground,
    textTheme: _buildTextTheme(base.textTheme),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: PhotoDatabaseColors.gray,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: PhotoDatabaseColors.inputBackground,
      focusedBorder: InputBorder.none,
    ),
    visualDensity: VisualDensity.standard,
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        bodyText2: GoogleFonts.comfortaa(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: letterSpacingOrNone(0.5),
        ),
        bodyText1: GoogleFonts.roboto(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          letterSpacing: letterSpacingOrNone(1.4),
        ),
        button: GoogleFonts.comfortaa(
          fontWeight: FontWeight.w700,
          letterSpacing: letterSpacingOrNone(2.8),
          fontSize: 13,
        ),
        headline5: GoogleFonts.roboto(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacingOrNone(1.4),
        ),
      )
      .apply(
        displayColor: Colors.white,
        bodyColor: Colors.white,
      );
}