import 'dart:async';
// import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/services.dart';

import '../../services/sentry/client.dart';

RemoteConfig remoteConfig;

Future<void> setupRemoteConfig() async {
  remoteConfig = await RemoteConfig.instance;

  // Enable developer mode to relax fetch throttling
  await remoteConfig
      .setConfigSettings(RemoteConfigSettings(debugMode: debugMode));

  // final String path = 'lib/resources/remote_config_defaults.json';
  // final String data = await rootBundle.loadString(path);
  // final Map<String, dynamic> defaults = json.decode(data);
  // await remoteConfig.setDefaults(defaults);
  await remoteConfig.setDefaults({
    'text__title': 'PikApp',
  });
}

Future<void> fetchRemoteConfig() async {
  // Using zero duration to force fetching from remote server in debug.
  final expiration = debugMode ? Duration(seconds: 0) : Duration(hours: 8);

  await remoteConfig.fetch(expiration: expiration).timeout(
        Duration(seconds: 10),
      );
  await remoteConfig.activateFetched();
}
