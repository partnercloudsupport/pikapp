import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:pikapp/config/constants.dart';
import 'package:pikapp/locale/localizations.dart';

import 'theme_dialog.dart';

ThemeDialog _buildThemeDialog(BuildContext context) => ThemeDialog();

void _changeTheme(BuildContext context) =>
    showDialog<Null>(context: context, builder: _buildThemeDialog);

Future<void> _sendFeedback() => url_launcher.launch(storeAndroidUrl);

void _showAboutDialog(BuildContext context) {
  final localizations = AppLocalizations.of(context);

  final title = localizations.translate('title');
  final madeWith = localizations.translate('made_with');
  // final PackageInfo package = await PackageInfo.fromPlatform();

  return showAboutDialog(
    context: context,
    applicationIcon: Image.asset('lib/resources/assets/icon.png', height: 48.0),
    applicationName: title,
    // applicationVersion: 'Version ${package.version}',
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('$madeWith '),
          const Icon(Icons.favorite, color: Colors.red),
          const Text(' in '),
          const FlutterLogo(),
        ],
      ),
    ],
  );
}

class HomeMenuButton extends StatelessWidget {
  void _onSelected(value) => value is Function ? value() : null;

  List<PopupMenuItem> _buildItems(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return <PopupMenuItem>[
      PopupMenuItem(
        value: () => _changeTheme(context),
        child: Text(localizations.translate('change_theme')),
      ),
      PopupMenuItem(
        value: _sendFeedback,
        child: Text(localizations.translate('send_feedback')),
      ),
      PopupMenuItem(
        value: () => _showAboutDialog(context),
        child: Text(localizations.translate('about')),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => PopupMenuButton(
        onSelected: _onSelected,
        itemBuilder: _buildItems,
      );
}
