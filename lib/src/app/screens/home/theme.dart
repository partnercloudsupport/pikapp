import 'package:flutter/material.dart';

import '../../../lib/dynamic_theme.dart';
import '../../locale/localizations.dart';

class ThemeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String dialog_title = localizations.translate('theme_dialog_title');
    String light = localizations.translate('theme_light');
    String dark = localizations.translate('theme_dark');

    Brightness brightness = Theme.of(context).brightness;
    Function onChanged = DynamicTheme.of(context).setBrightness;

    return SimpleDialog(
      title: Text(dialog_title),
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
