import 'package:flutter/material.dart';

import '../../lib/firebase/remote_config.dart';
import './localizations_delegate.dart';

class AppLocalizations {
  static final delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(String key) => remoteConfig?.getString('text__$key') ?? '';
}
