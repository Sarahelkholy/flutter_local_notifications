import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> notificationsStream =
      StreamController();
  static onTap(NotificationResponse notificationResponse) {
    notificationsStream.add(notificationResponse);
  }

  static Future<FlutterLocalNotificationsPlugin> initPlugin() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Initialize Android + iOS settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Initialize timezone
    tz.initializeTimeZones();
    final TimezoneInfo timeZone = (await FlutterTimezone.getLocalTimezone());
    tz.setLocalLocation(tz.getLocation(timeZone.identifier));

    return flutterLocalNotificationsPlugin;
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  /// basic notifications
  static void showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'id1',
        'Basic Notifications',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound(
          'sound.wav'.split('.').first,
        ),
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Basic notification',
      'This is a basic notification',
      details,
      payload: 'Payload Data',
    );
  }

  /// repeated notifications
  static void showRepeatedNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id2',
        'Repeated Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Repeated notification',
      'This is a repeated notification',
      RepeatInterval.everyMinute,
      details,
      payload: 'Payload Data',
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  /// scheduel notifications
  static void showScheduelNotification() async {
    NotificationDetails details = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id3',
        'Scheduel Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    tz.initializeTimeZones();
    final TimezoneInfo timeZoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Scheduel notification',
      'This is a scheduel notification',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),

      // tz.TZDateTime(tz.local, 2025, 12, 17, 13, 42),
      details,
      payload: 'This is a scheduel notification',
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  ///daily scheduel notifications

  static Future<void> showDailyScheduledNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'daily_id',
          'Daily Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      now.hour,
      30,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(hours: 10));
      log('Scheduled time updated: $scheduledTime');
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      'Daily Scheduled Notification',
      'This is a daily scheduled notification',
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
      payload: 'zonedSchedule',
    );
  }

  /// cancel
  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
