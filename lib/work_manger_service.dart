import 'package:local_notifications/local_notifications_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyTask() async {
    await Workmanager().registerPeriodicTask("id1", "simplePeriodicTask");
  }

  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  void cancelAllTasks(String id) {
    Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm:entry-point')
void actionTask() {
  Workmanager().executeTask((task, inputData) {
    LocalNotificationsService.showBasicNotification();
    return Future.value(true);
  });
}
