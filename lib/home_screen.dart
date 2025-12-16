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
                onPressed: () {},
                icon: Icon(Icons.cancel, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
