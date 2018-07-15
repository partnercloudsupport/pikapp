import 'package:flutter/material.dart';

import '../../../lib/firebase/analytics.dart';
import '../../locale/localizations.dart';
import '../event/event.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String tooltip =
        AppLocalizations.of(context).translate('home_fab_tooltip');

    return FloatingActionButton(
      child: Icon(Icons.flare),
      onPressed: () {
        analytics.logEvent(name: 'fab_button');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EventScreen(),
          ),
        );
      },
      tooltip: tooltip,
    );
  }
}
