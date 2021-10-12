import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManagger {
  PushNotificationManagger._();
  factory PushNotificationManagger() => _instance;
  static final PushNotificationManagger _instance =
      PushNotificationManagger._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
  Future init() async {
    if (!_initialized) {
      //ios
      _firebaseMessaging.requestPermission();

      String token = await _firebaseMessaging.getToken();
      print('my new token = $token');
      _initialized = true;
      return token;
    }
  }
}
