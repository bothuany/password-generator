import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    if (isDarkTheme) {
      return ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      );
    } else
      return ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      );
  }
}
