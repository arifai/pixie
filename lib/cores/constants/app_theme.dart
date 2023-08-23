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
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );
  }
}
