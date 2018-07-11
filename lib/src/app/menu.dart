import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../config/constants.dart';
import './locale/localizations.dart';

class AppMenuButton extends StatelessWidget {
  Future<void> _onSelected(dynamic value) async {
    if (value is String) return url_launcher.launch(value);

    final AppLocalizations localizations = AppLocalizations.of(value);

    final title = localizations.translate('title');
    final made_with = localizations.translate('made_with');
    // final PackageInfo package = await PackageInfo.fromPlatform();

    return showAboutDialog(
      context: value,
      applicationIcon:
          Image.asset('lib/resources/assets/icon.png', height: 48.0),
      applicationName: title,
      // applicationVersion: 'Version ${package.version}',
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$made_with '),
            Icon(Icons.favorite, color: Colors.red),
            Text(' in '),
            FlutterLogo(),
          ],
        ),
      ],
    );
  }

  List<PopupMenuItem> _buildItems(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return <PopupMenuItem>[
      PopupMenuItem(
        value: storeAndroidUrl,
        child: Text(localizations.translate('send_feedback')),
      ),
      PopupMenuItem(
        value: context,
        child: Text(localizations.translate('about')),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: _onSelected,
      itemBuilder: _buildItems,
    );
  }
}
