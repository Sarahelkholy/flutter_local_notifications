import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsDetailsScreen extends StatelessWidget {
  final NotificationResponse response;
  const NotificationsDetailsScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Details')),
      body: Center(child: Text('${response.id} : ${response.payload}')),
    );
  }
}
