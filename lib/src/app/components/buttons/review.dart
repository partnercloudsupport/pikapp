import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:pikapp/src/analytics.dart';

class ReviewIconButton extends StatelessWidget {
  static final String url =
      "http://play.google.com/store/apps/details?id=yt.pikatea.app";

  void _onPressed() async {
    analytics.logEvent(name: 'review_button');

    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite),
      onPressed: _onPressed,
      tooltip: 'Leave a review',
    );
  }
}
