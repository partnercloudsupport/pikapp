import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

import 'config/secrets.dart' show sentryDsn;

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
            tags: {'device': device},
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
