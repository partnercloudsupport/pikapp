import 'package:flutter/material.dart';

import 'package:pikapp/widgets/dynamic_theme.dart';

import 'app.dart';

class AppTheme extends StatelessWidget {
  // Widget _buildApp(BuildContext context, ThemeData theme) =>
  // App(theme: theme);
  Widget _buildApp(BuildContext context, Brightness brightness) => App(
        theme: ThemeData(
          brightness: brightness,
          fontFamily: 'Nunito',
          primarySwatch: Colors.pink,
        ),
      );

  @override
  Widget build(BuildContext context) => DynamicTheme(
        defaultTheme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Nunito',
          primarySwatch: Colors.pink,
        ),
        builder: _buildApp,
      );
}
