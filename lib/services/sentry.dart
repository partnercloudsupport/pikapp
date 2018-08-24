import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry/sentry.dart';

import '../config/constants.dart';

class Sentry {
  final SentryClient _client;

  Sentry({
    @required String device,
    @required String environment,
    @required String release,
  }) : _client = SentryClient(
          dsn: sentryDsn,
          environmentAttributes: Event(
            environment: environment,
            release: release,
            tags: <String, String>{
              'device': device,
            },
          ),
        );

  /// Reports [exception] along with its [stackTrace] to Sentry
  Future<SentryResponse> captureException(
      Exception exception, StackTrace stackTrace) async {
    debugPrint('Oops! ಠ_ಠ Something went wrong: $exception');

    return _client.captureException(
      exception: exception,
      stackTrace: stackTrace,
    );
  }
}

Future<void> setupSentry() async {
  if (debugMode) return;

  const environment = debugMode ? 'debug' : 'release';

  final package = await PackageInfo.fromPlatform();
  final device = DeviceInfoPlugin();

  String deviceModel;
  try {
    if (Platform.isAndroid) {
      deviceModel = (await device.androidInfo).model;
    } else if (Platform.isIOS) {
      deviceModel = (await device.iosInfo).model;
    }
  } on PlatformException {
    deviceModel = 'Unknown';
  }

  final sentry = Sentry(
    device: deviceModel,
    environment: environment,
    release: package.version,
  );

  FlutterError.onError =
      (details) => sentry.captureException(details.exception, details.stack);
}
