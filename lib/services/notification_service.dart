import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:app1/models/reminder_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helpers/id_generator.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _requestNotificationPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
  }

  Future<void> _requestNotificationPermission() async {
    PermissionStatus notificationStatus = await Permission.notification.status;

    if (!notificationStatus.isGranted) {
      await Permission.notification.request();
    }
  }

  Future<void> scheduleNotification(Reminder reminder) async {
    final bool? canScheduleExactAlarms =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.canScheduleExactNotifications();

    if (canScheduleExactAlarms == true) {
      final androidDetails = AndroidNotificationDetails(
        'your_channel_id',
        'Your Channel Name',
        channelDescription: 'Your Channel Description',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 60 * 1000,
      );

      final platformDetails = NotificationDetails(android: androidDetails);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        generateShortId(),
        reminder.title,
        "Hora de fazer a tarefa",
        tz.TZDateTime.from(reminder.dateTime, tz.local),
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exact,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } else {
      print('O sistema não permite alarmes exatos.');

      // OPCIONAL: abrir as configurações
      await openExactAlarmSettings();
    }
  }

  // Método para abrir configurações de alarmes exatos
  Future<void> openExactAlarmSettings() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }
}
