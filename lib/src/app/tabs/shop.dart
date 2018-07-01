import 'package:flutter/material.dart';

import '../locale/localizations.dart';

class ShopTab extends StatelessWidget {
  static final TextStyle textStyle =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final String text =
        AppLocalizations.of(context).translate('text_coming_soon');

    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(text, style: textStyle),
          ),
          Image.asset(
            'lib/assets/icon.png',
            height: 120.0,
          ),
        ],
      ),
    );
  }
}
