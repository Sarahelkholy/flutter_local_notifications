import 'dart:developer';
import 'package:local_notifications/local_notifications_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static const String taskName = "show_daily_notification";

  Future<void> init() async {
    log('Initializing WorkManager...');
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    await registerTask();
  }

  Future<void> registerTask() async {
    await Workmanager().registerPeriodicTask(
      'daily_notification_id',
      taskName,
      frequency: const Duration(minutes: 15),
      initialDelay: const Duration(minutes: 1),
    );
    log('Task registered');
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelAll();
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    log('Background task executing: $task');

    // Initialize plugin inside background isolate
    final flutterLocalNotificationsPlugin =
        await LocalNotificationsService.initPlugin();

    // Show scheduled notification
    await LocalNotificationsService.showDailyScheduledNotification(
      flutterLocalNotificationsPlugin,
    );

    return Future.value(true);
  });
}
