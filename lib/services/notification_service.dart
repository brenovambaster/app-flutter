import 'package:app1/helpers/id_generator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:app1/models/reminder_model.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Inicialização da configuração para Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuração de inicialização geral
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    tz.setLocalLocation(
      tz.getLocation('America/Sao_Paulo'),
    );
  }

  Future<void> scheduleNotification(Reminder reminder) async {
    final androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      generateShortId(),
      reminder.title, // Título da notificação
      "Hora de fazer a tarefa", // Descrição da notificação
      tz.TZDateTime.from(reminder.dateTime, tz.local),
      // Data e hora formatada corretamente
      platformDetails, // Detalhes da plataforma
      androidScheduleMode:
          AndroidScheduleMode
              .exact, // Garantindo que a notificação seja exibida mesmo se o dispositivo estiver inativo
    );
  }
}
