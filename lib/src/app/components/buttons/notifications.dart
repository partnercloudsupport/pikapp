import 'package:flutter/material.dart';

import 'package:pikapp/src/analytics.dart';

import '../../locale/localizations.dart';

class NotificationIconButton extends StatelessWidget {
  static final _snackBar = SnackBar(
    duration: Duration(seconds: 5),
    content: Text("Push notifications will be available soon!"),
    action: SnackBarAction(
      label: 'OKAY',
      onPressed: () {
        analytics.logEvent(name: 'notification_okay');
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    String tooltip =
        AppLocalizations.of(context).translate('notifications_tooltip');

    return IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {
        analytics.logEvent(name: 'notification_button');
        Scaffold.of(context).showSnackBar(_snackBar);
      },
      tooltip: tooltip,
    );
  }
}
