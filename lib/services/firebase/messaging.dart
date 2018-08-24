import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging messaging = FirebaseMessaging();

void setupMessaging() {
  messaging
    ..configure(
      onMessage: (message) {
        print('onMessage: $message');
      },
      onLaunch: (message) {
        print('onLaunch: $message');
      },
      onResume: (message) {
        print('onResume: $message');
      },
    )
    ..requestNotificationPermissions();
}
