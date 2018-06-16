import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:pikapp/src/analytics.dart';

import '../../locale/localizations.dart';

class ReviewIconButton extends StatelessWidget {
  static final String url =
      "http://play.google.com/store/apps/details?id=yt.pikatea.app";

  void _onPressed() async {
    analytics.logEvent(name: 'review_button');

    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    }
  }

  AlertDialog _buildDialog(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String dialog_title = localizations.translate('review_dialog_title');
    String dialog_content = localizations.translate('review_dialog_content');
    String text_later = localizations.translate('text_later').toUpperCase();
    String text_sure = localizations.translate('text_sure').toUpperCase();

    return AlertDialog(
      title: Text(dialog_title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(dialog_content)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(text_later),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(text_sure),
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
    String tooltip = AppLocalizations.of(context).translate('review_tooltip');

    return IconButton(
      icon: Icon(Icons.favorite),
      onPressed: () =>
          showDialog<Null>(context: context, builder: _buildDialog),
      tooltip: tooltip,
    );
  }
}
