import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import 'app.dart';

class AppTheme extends StatelessWidget {
  Widget _buildApp(BuildContext context, ThemeData theme) => App(theme: theme);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (Brightness brightness) => ThemeData(
            accentColor:
                brightness == Brightness.light ? null : primaryColor[200],
            brightness: brightness,
            fontFamily: 'Nunito',
            primarySwatch: primaryColor,
          ),
      themedWidgetBuilder: _buildApp,
    );
  }
}
