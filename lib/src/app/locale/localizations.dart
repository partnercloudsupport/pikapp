import 'dart:async';
import 'dart:convert';

// import 'package:firebase_remote_config/firebase_remote_config.dart';
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

  // RemoteConfig _remoteConfig;
  Map<String, String> _translations = new Map<String, String>();

  Future<bool> load() async {
    // if (this.locale.languageCode == 'en') {
    //   _remoteConfig = await RemoteConfig.instance;
    //   // Using default duration to force fetching from remote server.
    //   await _remoteConfig.fetch(expiration: const Duration(seconds: 0));
    //   await _remoteConfig.activateFetched();
    // }

    final String path =
        'lib/src/resources/lang/${this.locale.languageCode}.json';
    final String data = await rootBundle.loadString(path);
    final Map<String, dynamic> result = json.decode(data);

    result.forEach((String key, dynamic value) {
      _translations[key] = value.toString();
    });

    return true;
  }

  String translate(String key) {
    // String value = this._remoteConfig.getString('text__$key');
    // if (value.isNotEmpty) return value;
    return this._translations[key] ?? '';
  }
}
