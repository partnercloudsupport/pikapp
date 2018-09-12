import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';

// This file does not exist in the repository and is .gitignored. In your local
// clone of this repository, create this file and add a top-level [String]
// constant containing the DSN value issued by Sentry to your project.
//
// This method of supplying DSN is only for demo purposes. In a real app you
// might want to get it using a more robust method, such as via environment
// variables, a configuration file or a platform-specific secret key storage.
import 'dsn.dart';

/// Whether the VM is running in debug mode.
///
/// This is useful to decide whether a report should be sent to sentry. Usually
/// reports from dev mode are not very useful, as these happen on developers'
/// workspaces rather than on users' devices in production.
bool get debugMode {
  // Assume we're in production mode
  var dev = false;

  // Assert expressions are only evaluated during development. They are ignored
  // in production. Therefore, this code will only turn `dev` to true
  // in our development environments!
  assert(dev = true);

  return dev;
}

/// Sentry client used to send crash reports (or more generally "events").
///
/// This client uses the default client parameters. For example, it uses a
/// plain HTTP client that does not retry failed report attempts and does
/// not support offline mode. You might want to use a different HTTP client,
/// one that has these features. Please read the documentation for the
/// [SentryClient] constructor to learn how you can customize it.
///
/// [SentryClient.environmentAttributes] are particularly useful in a real
/// app. Use them to specify attributes of your app that do not change from
/// one event to another, such as operating system type and version, the
/// version of Flutter, and [device information][1].
///
/// [1]: https://github.com/flutter/plugins/tree/master/packages/device_info
final SentryClient _sentry = SentryClient(dsn: dsn);

/// Reports [error] along with its [stackTrace] to Sentry.
Future<Null> onError(Exception error, StackTrace stackTrace) async {
  debugPrint('Caught error: $error');

  // final package = await PackageInfo.fromPlatform();
  // final device = DeviceInfoPlugin();

  // String deviceModel;
  // try {
  //   if (Platform.isAndroid) {
  //     deviceModel = (await device.androidInfo).model;
  //   } else if (Platform.isIOS) {
  //     deviceModel = (await device.iosInfo).model;
  //   }
  // } on PlatformException {
  //   deviceModel = 'Unknown';
  // }

  final response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    debugPrint('Success! Event ID: ${response.eventId}');
  } else {
    debugPrint('Failed to report to Sentry: ${response.error}');
  }
}
