// providers/app_providers.dart
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../controllers/counter_controller.dart';
import '../controllers/fuel_controller.dart';
import '../controllers/reminder_controller.dart';
import '../controllers/pharmacy_controller.dart';
import '../services/notification_service.dart';
import '../services/reminder_storage_service.dart';

// Imports dos use cases e repositories da farmácia

import '../repositories/product_repository_impl.dart';

import '../usercases/filter_products_usercase.dart';
import '../usercases/get_categories_usecase.dart';

final List<SingleChildWidget> appProviders = [
  // Seus providers existentes
  ChangeNotifierProvider(create: (_) => FuelController()),
  ChangeNotifierProvider(create: (_) => CounterController()),
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

  // NOVO: PharmacyController
  ChangeNotifierProvider(
    create: (_) {
      final controller = PharmacyController(
        productRepository: ProductRepositoryImpl(),
        filterProductsUseCase: FilterProductsUseCase(),
        getCategoriesUseCase: GetCategoriesUseCase(),
      );
      controller.initialize();
      return controller;
    },
  ),
];
