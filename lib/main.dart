import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import 'src/sentry.dart';
import 'src/app/app.dart';

Future<void> setupApp() async {
  final String environment =
      bool.fromEnvironment('dart.vm.product') ? 'release' : 'debug';

  if (environment != 'release') return;

  final PackageInfo package = await PackageInfo.fromPlatform();
  final DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
  String device;
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await devicePlugin.androidInfo;
      device = deviceInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await devicePlugin.iosInfo;
      device = deviceInfo.model;
    }
  } on PlatformException {
    device = 'Unknown';
  }

  final Sentry sentry = Sentry(
    device: device,
    environment: environment,
    release: package.version,
  );

  FlutterError.onError = (FlutterErrorDetails details) =>
      sentry.captureException(details.exception, details.stack);
}

void main() {
  setupApp();

  return runApp(App());
}
