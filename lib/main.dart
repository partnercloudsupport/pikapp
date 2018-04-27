import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show runApp;
import 'package:flutter/services.dart' show PlatformException;
import 'package:package_info/package_info.dart';

import 'src/sentry.dart' show Sentry;
import 'src/app/app.dart';

Future<void> main() async {
  final String environment =
      bool.fromEnvironment('dart.vm.product') ? 'release' : 'debug';

  if (environment == 'release') {
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
        environment: environment,
        release: package.version,
        loggerName: package.packageName,
        serverName: device);

    FlutterError.onError = (FlutterErrorDetails details) =>
        sentry.reportError(details.exception, details.stack);
  }

  final App app = App();
  return runApp(app);
}
