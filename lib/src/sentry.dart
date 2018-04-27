import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

import 'config/secrets.dart' show sentryDsn;

class Sentry {
  final SentryClient _client;

  Sentry({
    @required String environment,
    @required String release,
    String loggerName,
    String serverName,
  }) : _client = SentryClient(
            dsn: sentryDsn,
            environmentAttributes: Event(
                environment: environment,
                release: release,
                loggerName: loggerName,
                serverName: serverName));

  /// Reports [error] along with its [stackTrace] to Sentry
  Future<bool> reportError(dynamic error, StackTrace stackTrace) async {
    debugPrint('Oops! ಠ_ಠ Something went wrong: $error');

    final SentryResponse response = await _client.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
    return response.isSuccessful;
  }
}
