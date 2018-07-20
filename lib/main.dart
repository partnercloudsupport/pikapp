import 'dart:async';

import 'package:flutter/material.dart';

import 'src/app/theme.dart';
import 'src/lib/firebase/messaging.dart';
import 'src/lib/firebase/remote_config.dart';
import 'src/lib/sentry.dart';

Future<void> setupApp() async {
  setupSentry();
  setupMessaging();
  await setupRemoteConfig();

  // await Future.delayed(Duration(seconds: 3));
}

void main() async {
  await setupApp();
  runApp(AppTheme());
}
