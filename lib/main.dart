import 'package:flutter/material.dart';
import 'package:local_notifications/home_screen.dart';
import 'package:local_notifications/local_notifications_service.dart';
import 'package:local_notifications/work_manger_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications plugin in main isolate
  await LocalNotificationsService.initPlugin();

  // Initialize WorkManager
  await WorkManagerService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Notifications Demo',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const HomeScreen(),
    );
  }
}
