// coverage:ignore-file

import 'package:flutter/material.dart';

/// {@template app_theme}
/// A class for custom theme.
/// {@endtemplate app_theme}
class AppTheme {
  /// {@macro app_theme}
  const AppTheme();

  /// App base theme.
  ThemeData get base {
    const TextStyle bodyStyle = TextStyle(fontFamily: 'Poppins', height: 1.5);
    const TextStyle headlineStyle = TextStyle(
      fontFamily: 'RobotoSlab',
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
    TextTheme textTheme = TextTheme(
      headlineLarge: headlineStyle,
      headlineMedium: headlineStyle,
      headlineSmall: headlineStyle,
      bodyLarge: bodyStyle,
      bodyMedium: bodyStyle,
      bodySmall: bodyStyle,
      titleLarge: bodyStyle.copyWith(fontWeight: FontWeight.w500),
      titleMedium: bodyStyle.copyWith(fontWeight: FontWeight.w500),
      titleSmall: bodyStyle.copyWith(fontWeight: FontWeight.normal),
      labelLarge: bodyStyle.copyWith(
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: 16,
      ),
      labelMedium: bodyStyle.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 16,
      ),
      labelSmall: bodyStyle.copyWith(
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      primaryTextTheme: textTheme,
      textTheme: textTheme,
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(0),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          backgroundColor: MaterialStatePropertyAll(Colors.indigo),
          fixedSize: MaterialStatePropertyAll(Size(370, 56)),
        ),
      ),
    );
  }
}
