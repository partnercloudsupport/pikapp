import 'dart:async';

import 'package:flutter/material.dart';

import 'localizations.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations();

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
