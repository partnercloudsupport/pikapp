import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:pikapp/config/constants.dart';
import 'package:pikapp/locale/localizations.dart';
import 'package:pikapp/services/firebase/analytics.dart';

class ReviewIconButton extends StatelessWidget {
  void _onPressed() {
    analytics.logEvent(name: 'review_button');
    url_launcher.launch(storeAndroidUrl);
  }

  AlertDialog _buildDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final dialogTitle = localizations.translate('review_dialog_title');
    final dialogContent = localizations.translate('review_dialog_content');
    final textLater = localizations.translate('later').toUpperCase();
    final textSure = localizations.translate('sure').toUpperCase();

    return AlertDialog(
      title: Text(dialogTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(dialogContent)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(textLater),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(textSure),
          onPressed: () {
            Navigator.of(context).pop();
            _onPressed();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tooltip = AppLocalizations.of(context).translate('review_tooltip');

    return IconButton(
      icon: const Icon(Icons.favorite),
      onPressed: () =>
          showDialog<Null>(context: context, builder: _buildDialog),
      tooltip: tooltip,
    );
  }
}
