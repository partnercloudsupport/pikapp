import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pikapp/screens/theme.dart';
import 'package:pikapp/services/firebase/messaging.dart';
import 'package:pikapp/services/firebase/remote_config.dart';
import 'package:pikapp/services/sentry.dart';

Future<void> setupApp() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupSentry();
  setupMessaging();
  await setupRemoteConfig();

  // await Future.delayed(DuraxPtion(seconds: 3));
}

void main() async {
  await setupApp();
  runApp(AppTheme());
}
