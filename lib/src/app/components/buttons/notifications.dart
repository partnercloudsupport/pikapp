import 'package:flutter/material.dart';

import 'package:pikapp/src/analytics.dart';

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
    return IconButton(
      icon: Icon(Icons.notifications),
      onPressed: () {
        analytics.logEvent(name: 'notification_button');
        Scaffold.of(context).showSnackBar(_snackBar);
      },
      tooltip: 'Toggle notifications',
    );
  }
}
