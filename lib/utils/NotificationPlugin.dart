import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:io' show File;
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();
// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
   
  });
  final int id;
  final String title;
  final String body;
  final String payload;
 
}

class NotificationPlugin {
  NotificationPlugin.initTrack() {
    _configureSelectNotificationSubject();
  }
  static void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {});
  }

  static configureLocalTimeZone() async {
    //print("called");
    tz.initializeTimeZones();
    // final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    // final  timeZoneName = tz.getLocation('Asia');
    // tz.setLocalLocation(timeZoneName);
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_trp');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      
    );
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: false);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {});
  }

  static showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
           // ledColor: Colors.green,
           
            
           
            styleInformation: DefaultStyleInformation(true, true),
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'custom notification title', 'custom notification body', platformChannelSpecifics,
        payload: '@drawable/ic_trp');
  }

  

  handleCustomActionClick(String payload) {
    if(payload == "secondAction") {
        LocalNotifications.removeNotification(0);
    }
}

// createNotification() async{

// int id = await LocalNotifications.createNotification(
//     title: "Multiple Actions",
//     content: 'With custom callbacks',
//     id: 0,
//     onNotificationClick: new NotificationAction(
//         actionText: "Some action",
//         callback: onNotificationClick,
//         payload: "Some payload",
//         launchesApp: false
//     ),
//     actions: [
//         new NotificationAction(
//             actionText: "First",
//             callback: handleCustomActionClick,
//             payload: "firstAction",
//             launchesApp: true
//         ),
//         new NotificationAction(
//             actionText: "Second",
//             callback: handleCustomActionClick,
//             payload: "secondAction",
//             launchesApp: false
//         )
//     ]
// );
// }

}
