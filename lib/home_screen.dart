import 'package:flutter/material.dart';
import 'package:local_notifications/local_notifications_service.dart';
import 'package:local_notifications/notifications_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenToNotificationStream();
  }

  void listenToNotificationStream() {
    LocalNotificationsService.notificationsStream.stream.listen((
      notificationResponse,
    ) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              NotificationsDetailsScreen(response: notificationResponse),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: const Icon(Icons.notifications),
        title: const Text('Local Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {
                LocalNotificationsService.showBasicNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text('Basic Notification'),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationsService.cancelNotification(0);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            ListTile(
              onTap: () {
                LocalNotificationsService.showRepeatedNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text('Repeated Notification'),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationsService.cancelNotification(1);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),

            ListTile(
              onTap: () {
                LocalNotificationsService.showScheduelNotification();
              },
              leading: Icon(Icons.notifications),
              title: Text('Schedual Notification'),
              trailing: IconButton(
                onPressed: () {
                  LocalNotificationsService.cancelNotification(2);
                },
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalNotificationsService.flutterLocalNotificationsPlugin
                    .cancelAll();
              },
              child: const Text('Cancel All'),
            ),
          ],
        ),
      ),
    );
  }
}
