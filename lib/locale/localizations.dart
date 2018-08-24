import 'package:flutter/material.dart';

import 'package:pikapp/services/firebase/remote_config.dart';

import 'localizations_delegate.dart';

class AppLocalizations {
  static final AppLocalizationsDelegate delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  String translate(String key) => remoteConfig?.getString('text__$key') ?? '';
}
