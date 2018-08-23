import 'package:flutter/material.dart';

import '../config/constants.dart';
import '../lib/dynamic_theme.dart';
import 'app.dart';

class AppTheme extends StatelessWidget {
  // Widget _buildApp(BuildContext context, ThemeData theme) => App(theme: theme);
  Widget _buildApp(BuildContext context, Brightness brightness) => App(
        theme: ThemeData(
          brightness: brightness,
          fontFamily: 'Nunito',
          primarySwatch: primaryColor,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultTheme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Nunito',
        primarySwatch: primaryColor,
      ),
      builder: _buildApp,
    );
  }
}
