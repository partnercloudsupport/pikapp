import 'package:flutter/material.dart';

import '../../locale/localizations.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String title = localizations.translate('event');
    String text = localizations.translate('no_events');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_dissatisfied,
              color: Theme.of(context).accentColor,
              size: 56.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
