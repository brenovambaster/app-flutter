import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:app1/models/reminder_model.dart';
import 'package:app1/helpers/id_generator.dart';
import 'package:permission_handler/permission_handler.dart'; // Para gerenciar permissões

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Solicitar permissão para notificações e alarmes exatos
    await _requestPermissions();

    // Inicialização da configuração para Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuração de inicialização geral
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Inicializando o plugin
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Configurações de timezone
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
  }

  // Método para solicitar permissões para notificações e alarmes exatos
  Future<void> _requestPermissions() async {
    // Verificar a permissão para notificações
    PermissionStatus notificationStatus = await Permission.notification.status;

    // Se a permissão de notificações não foi concedida, solicitar
    if (!notificationStatus.isGranted) {
      await Permission.notification.request();
    }

    // Verificar e solicitar permissão de alarmes exatos para Android 12+
    // NOTA: NÃO FUNCIONOU AINDA.
    // if (await Permission.alarm.request().isGranted) {
    //   print("Permissão de alarmes exatos concedida!");
    // } else {
    //   print("Permissão de alarmes exatos não concedida.");
    // }
  }

  Future<void> scheduleNotification(Reminder reminder) async {
    // Agendando a notificação com timezone e modo exato
    final androidDetails = AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 60 * 1000, // 60 segundos em milissegundos
    );

    final platformDetails = NotificationDetails(android: androidDetails);

    // Agendando a notificação com timezone e modo exato
    await flutterLocalNotificationsPlugin.zonedSchedule(
      generateShortId(),
      reminder.title,
      "Hora de fazer a tarefa",
      tz.TZDateTime.from(reminder.dateTime, tz.local),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exact, // Modo exato
      matchDateTimeComponents:
          DateTimeComponents.time, // Match com hora e minuto
    );
  }
}
