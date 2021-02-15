import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotificationManagger{
  PushNotificationManagger._();
  factory PushNotificationManagger()=>_instance;
  static final PushNotificationManagger _instance=PushNotificationManagger._();
  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
  bool _initialized=false;
  Future init()async{
    if(!_initialized){
      //ios
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

      },  onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },   onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

      },);
      String token=await _firebaseMessaging.getToken();

      print('my new token = $token');
      _initialized=true;
return token;
    }
  }
}








