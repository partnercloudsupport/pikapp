import 'package:flutter/material.dart';

import '../../lib/firebase/analytics.dart';
import '../app.dart';
import '../locale/localizations.dart';

class AppFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String tooltip =
        AppLocalizations.of(context).translate('fab_tooltip');

    return FloatingActionButton(
      child: Icon(Icons.palette),
      onPressed: () {
        analytics.logEvent(name: 'fab_button');

        AppData app = App.of(context);

        switch (app.brightness) {
          case Brightness.light:
            return app.setBrightness(Brightness.dark);
          default:
            return app.setBrightness(Brightness.light);
        }
      },
      tooltip: tooltip,
    );
  }
}
