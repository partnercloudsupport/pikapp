import 'package:flutter/material.dart';

import 'package:pikapp/locale/localizations.dart';
import 'package:pikapp/widgets/dynamic_theme.dart';

class ThemeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final dialogTitle = localizations.translate('theme_dialog_title');
    final light = localizations.translate('theme_light');
    final dark = localizations.translate('theme_dark');

    final brightness = Theme.of(context).brightness;
    final onChanged = DynamicTheme.of(context).setBrightness;

    return SimpleDialog(
      title: Text(dialogTitle),
      children: <Widget>[
        RadioListTile(
          title: Text(light),
          value: Brightness.light,
          groupValue: brightness,
          onChanged: onChanged,
        ),
        RadioListTile(
          title: Text(dark),
          value: Brightness.dark,
          groupValue: brightness,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
