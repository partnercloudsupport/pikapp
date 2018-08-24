import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/theme.dart';
import 'services/firebase/messaging.dart';
import 'services/firebase/remote_config.dart';
import 'services/sentry.dart';

Future<void> setupApp() async {
  await setupSentry();
  setupMessaging();
  await setupRemoteConfig();

  // await Future.delayed(Duration(seconds: 3));
}

void main() async {
  await setupApp();
  runApp(AppTheme());
}
