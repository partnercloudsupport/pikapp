import 'package:flutter/material.dart';

import 'package:pikapp/locale/localizations.dart';
import 'package:pikapp/services/firebase/analytics.dart';
import 'package:pikapp/screens/event/event.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tooltip = AppLocalizations.of(context).translate('home_fab_tooltip');

    return FloatingActionButton(
      child: const Icon(Icons.flare),
      onPressed: () {
        analytics.logEvent(name: 'fab_button');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventScreen(),
          ),
        );
      },
      tooltip: tooltip,
    );
  }
}
