import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sahlaprovider/scr/contactwithmanager.dart';
import 'package:sahlaprovider/scr/get_future_orders.dart';
import 'package:sahlaprovider/scr/get_list_reservation.dart';
import 'package:sahlaprovider/scr/myorder.dart';
import 'package:sahlaprovider/scr/notificationScr.dart';
import 'package:sahlaprovider/scr/pharmacy.dart';

class NotificationHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    //tz.initializeTimeZones();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("log");

    final InitializationSettings initializationSettings =
        InitializationSettings(
            initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  // void requestIOSPermissions() {
  //   flutterLocalNotificationsPlugin.
  //       resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  // }

  Future selectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
      if (payload == "1") {
        return Get.to(MyOrder());
      }
      if (payload == "2") {
        return Get.to(Get_Future_Orders());
      }
      if (payload == "3") {
        return Get.to(Pharmacy());
      }
      if (payload == "4") {
        return Get.to(Get_list_reservation());
      }
      if (payload == "5") {
        return Get.to(MyOrder());
      }
      if (payload == "6") {
        return Get.to(MyOrder());
      }
      if (payload == "7") {
        return Get.to(NotificationScr());
      }
    } else {
      print("Notification Done");
    }
  }

  displayNotification(
      {@required String title,
      @required String body,
      @required String payload}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // scheduledNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'theme changes 5 seconds ago',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('your channel id',
  //               'your channel name', 'your channel description')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }
}
