import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  // Instância única do plugin como singleton
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  // Plugin de notificações
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Canal Android para notificações
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        'reminder_channel', // id
        'Lembretes', // title
        description: 'Notificações de lembretes agendados',
        importance: Importance.max,
        enableVibration: true,
      );

  /// Inicializa o plugin e o fuso-horário
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Inicializa os dados de fuso horário
    tz.initializeTimeZones();

    // Obtém o fuso horário local do dispositivo
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // Configurações de inicialização para Android
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configurações para iOS (caso necessário no futuro)
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Configuração completa de inicialização
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    // Inicializa o plugin com as configurações
    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Cria o canal no Android
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);
  }

  // Manipulador para quando o usuário toca na notificação
  void _onNotificationTapped(NotificationResponse details) {
    // Implemente aqui a lógica para quando o usuário tocar na notificação
    // Por exemplo: navegação para uma tela específica
  }

  /// Agenda uma notificação com [id] para [scheduledDate]
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await _plugin.zonedSchedule(
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          enableVibration: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      payload: payload,
    );
  }

  /// Agenda uma notificação recorrente (diária)
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay timeOfDay,
    String? payload,
  }) async {
    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    await _plugin.zonedSchedule(
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      id,
      title,
      body,
      _scheduleDaily(scheduledDate),
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),

      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  // Função auxiliar para agendar notificações diárias
  tz.TZDateTime _scheduleDaily(DateTime scheduledDate) {
    final now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledTZDate = tz.TZDateTime(
      tz.local,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
    );

    if (scheduledTZDate.isBefore(now)) {
      scheduledTZDate = scheduledTZDate.add(const Duration(days: 1));
    }

    return scheduledTZDate;
  }

  /// Cancela uma notificação específica
  Future<void> cancel(int id) async => await _plugin.cancel(id);

  /// Cancela todas as notificações agendadas
  Future<void> cancelAll() async => await _plugin.cancelAll();

  /// Verifica se as notificações estão habilitadas
  Future<bool> areNotificationsEnabled() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidPlugin != null) {
      return await androidPlugin.areNotificationsEnabled() ?? false;
    }

    return false;
  }

  /// Solicita permissão para enviar notificações (mais relevante para iOS)
  Future<bool> requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidPlugin != null) {
      try {
        // Para versões mais recentes da biblioteca
        final bool? granted =
            await androidPlugin.requestNotificationsPermission();
        return granted ?? false;
      } catch (e) {
        // Fallback ou manipulação de erro
        print('Erro ao solicitar permissão: $e');
        return false;
      }
    }

    return false;
  }

  /// Mostrar uma notificação imediata
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: payload,
    );
  }
}
