import 'package:flutter/material.dart';

import 'package:pikapp/src/analytics.dart';

import 'locale/localizations.dart';

class EventFloatingActionButton extends StatelessWidget {
  void _onPressed() {
    analytics.logEvent(name: 'fab_snackbar_action');
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    final String tooltip = localizations.translate('fab_tooltip');
    final List<String> snackbar_content_list = [
      localizations.translate('text_curious_person'),
      localizations.translate('text_mystery_button'),
      localizations.translate('text_retry_later'),
      localizations.translate('text_surprise'),
    ];
    final MaterialLocalizations material_localizations =
        MaterialLocalizations.of(context);

    return FloatingActionButton(
      child: Icon(Icons.flash_on),
      onPressed: () {
        analytics.logEvent(name: 'fab_button');

        final String snackbar_content =
            (snackbar_content_list..shuffle()).first;
        final SnackBar snackBar = SnackBar(
          duration: Duration(seconds: 5),
          content: Text(snackbar_content),
          action: SnackBarAction(
            label: material_localizations.okButtonLabel,
            onPressed: _onPressed,
          ),
        );

        ScaffoldState scaffold = Scaffold.of(context);
        scaffold.removeCurrentSnackBar();
        scaffold.showSnackBar(snackBar);
      },
      tooltip: tooltip,
    );
  }
}
