import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/scr/login.dart';
import 'package:sahlaprovider/scr/splashSCR.dart';
import 'Translation/Trans.dart';
import 'myWidget/testthemap.dart';
import 'netWORK/allnetworking.dart';
import 'notification_helper.dart';
import 'scr/QRread.dart';
import 'scr/branch.dart';
import 'scr/homePage.dart';
import 'scr/offer.dart';
import 'scr/statistics.dart';
import 'utilitie/hexToColorِConvert.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  notifyHelper.initializeNotification();
  notifyHelper.displayNotification(
      title: message.notification.title,
      body: message.notification.body,
      payload: message.data["type"]);
  print("Handling a background message: ${message.notification.body}");
}

NotificationHelper notifyHelper = NotificationHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      notifyHelper.initializeNotification();
      notifyHelper.displayNotification(
          title: message.notification.title,
          body: message.notification.body,
          payload: message.data["type"]);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await AndroidAlarmManager.initialize();
  String token = await FirebaseMessaging.instance.getToken();
  print('my new token = $token');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String token = box.read('token');

    return GetMaterialApp(
        locale: LocalizationService.locale,
        translations: LocalizationService(),
        fallbackLocale: LocalizationService.fallbackLocale,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Arbf',
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FutureBuilder<bool>(
          future: check(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(); // tstart();
              default:
                if (snapshot.hasError)
                  return tstart();
                else if (snapshot.data == false) {
                  return tstart();
                }
                return Splash(); // token!=null?Statisticss():LoginScr();//Statisticss();token!=null?Statisticss():

            }
          },
          initialData: false,
        ) // Statisticss():tstart()//HomePage(),ProductScr()//OfferScr()//QRClient()//
        );
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Widget tstart() {
    return Scaffold(
      body: Center(
        child: Text(
          ' لا يوجد اتصال بالإنترنت',
          style: TextStyle(color: hexToColor('#ed1c6f'), fontSize: 25),
        ),
      ),
    );
  }
}
