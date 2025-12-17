import 'package:flutter/material.dart';
import 'package:local_notifications/local_notifications_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
