import 'package:flutter/material.dart';

import '../lib/firebase/analytics.dart';
import './locale/localizations.dart';

class AppFloatingActionButton extends StatelessWidget {
  void _onPressed() {
    analytics.logEvent(name: 'fab_snackbar_action');
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context);
    final String tooltip = localizations.translate('fab_tooltip');
    final List<String> snackbar_content_list = [
      localizations.translate('curious_person'),
      localizations.translate('mystery_button'),
      localizations.translate('fab_tooltip'),
    ];

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
            label: MaterialLocalizations.of(context).okButtonLabel,
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
