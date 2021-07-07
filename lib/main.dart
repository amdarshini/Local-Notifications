import 'package:flutter/material.dart';
import 'package:localNotificationProject/utils/NotificationExample.dart';
import 'package:localNotificationProject/utils/NotificationPlugin.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  NotificationPlugin.configureLocalTimeZone();
  runApp(MyApp());
}class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationExample(),
    );
  }
}