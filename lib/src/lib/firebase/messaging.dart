import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging messaging = FirebaseMessaging();

void setupMessaging() {
  messaging.configure(
    onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
    },
    onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
    },
    onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
    },
  );

  messaging.requestNotificationPermissions();
}
