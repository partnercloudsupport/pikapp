import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'localizations_delegate.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  static final delegate = AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final Locale locale;

  Map<String, dynamic> _translations;

  Future<bool> load() async {
    String path = 'lib/src/resources/lang/${this.locale.languageCode}.json';
    String data = await rootBundle.loadString(path);
    this._translations = json.decode(data);
    return true;
  }

  String translate(String key) => this._translations[key] ?? '';
}
