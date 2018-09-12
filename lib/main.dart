import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pikapp/screens/theme.dart';
import 'package:pikapp/services/firebase/messaging.dart';
import 'package:pikapp/services/firebase/remote_config.dart';
import 'package:pikapp/services/sentry/client.dart';

Future<void> setupApp() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  setupMessaging();
  await setupRemoteConfig();

  return runApp(AppTheme());
}

void main() {
  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (details) {
    if (debugMode) {
      // Errors thrown in development mode are unlikely to be interesting.
      // Simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  // This creates a [Zone] that contains the Flutter application and stablishes
  // an error handler that captures errors and reports them.
  //
  // Using a zone makes sure that as many errors as possible are captured,
  // including those thrown from [Timer]s, microtasks, I/O, and those forwarded
  // from the `FlutterError` handler.
  //
  // More about zones:
  //
  // - https://api.dartlang.org/stable/1.24.2/dart-async/Zone-class.html
  // - https://www.dartlang.org/articles/libraries/zones
  runZoned<Future<void>>(setupApp, onError: onError);
}
