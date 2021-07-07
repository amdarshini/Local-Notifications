import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localNotificationProject/utils/NotificationPlugin.dart';
class NotificationExample extends StatefulWidget {
  @override
  _NotificationExampleState createState() => _NotificationExampleState();
}class _NotificationExampleState extends State<NotificationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification example"),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Show Notification"),
            onPressed: () async {
              print("predseed");
                await NotificationPlugin.showNotification();
             // NotificationPlugin.scheduleWeeklyMondayTenAMNotification();
            },
          ),
      ),),    );
  }

    
}