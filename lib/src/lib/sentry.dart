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

  /// Reports [error] along with its [stackTrace] to Sentry
  Future<SentryResponse> captureException(
      dynamic exception, StackTrace stackTrace) async {
    debugPrint('Oops! ಠ_ಠ Something went wrong: $exception');

    return _client.captureException(
      exception: exception,
      stackTrace: stackTrace,
    );
  }
}

Future<void> setupSentry() async {
  if (debugMode) return;

  final String environment = debugMode ? 'debug' : 'release';

  final PackageInfo package = await PackageInfo.fromPlatform();
  final DeviceInfoPlugin device = DeviceInfoPlugin();

  String deviceModel;
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await device.androidInfo;
      deviceModel = deviceInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await device.iosInfo;
      deviceModel = deviceInfo.model;
    }
  } on PlatformException {
    deviceModel = 'Unknown';
  }

  final Sentry sentry = Sentry(
    device: deviceModel,
    environment: environment,
    release: package.version,
  );

  FlutterError.onError = (FlutterErrorDetails details) =>
      sentry.captureException(details.exception, details.stack);
}
