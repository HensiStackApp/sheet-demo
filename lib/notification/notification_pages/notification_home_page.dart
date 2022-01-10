import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sheet_widget_demo/commonWidget/commonButton.dart';
import 'package:sheet_widget_demo/notification/notification_pages/firebase_notification_page.dart';

class NotificationHomePage extends StatefulWidget {
  const NotificationHomePage({Key key}) : super(key: key);

  @override
  _NotificationHomePageState createState() => _NotificationHomePageState();
}

class _NotificationHomePageState extends State<NotificationHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification page"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListView(
              children: [
                button(
                    context,
                    'Simple Notification',
                    () => showNotification('Flutter Local Notification',
                        'Flutter Simple Notification', 'Destination Screen (Simple Notification)')),
                button(context, "firebase Notification", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FireBaseNotificationHomePage(),
                      ));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showNotification(String title, String subtitle, String action) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        style: AndroidNotificationStyle.BigText,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher");
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, '$title', '$subtitle', platformChannelSpecifics,
        payload: action);
  }
}
