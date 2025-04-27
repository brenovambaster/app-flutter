import 'package:provider/provider.dart';
import '../controllers/counter_controller.dart';
import '../controllers/fuel_controller.dart';
import '../controllers/reminder_controller.dart';
import '../services/notification_service.dart';
import '../services/reminder_storage_service.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => FuelController()),
  ChangeNotifierProvider(create: (_) => CounterController()), // <--- ESSA LINHA
  ChangeNotifierProvider(
    create: (_) {
      final controller = ReminderController(
        notificationService: NotificationService(),
        storageService: ReminderStorageService(),
      );
      controller.initialize();
      return controller;
    },
  ),
];
