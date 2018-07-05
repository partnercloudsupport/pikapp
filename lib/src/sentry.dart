import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

class Sentry {
  final SentryClient _client;

  Sentry({
    @required String device,
    @required String environment,
    @required String release,
  }) : _client = SentryClient(
          dsn:
              'https://b98c7b2b8d9649ec92e4802c87b30767:60e2747913514272b9fe9ac0aabc0868@sentry.io/289984',
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
