import 'package:app1/models/product.dart';

class GetCategoriesUseCase {
  List<String> execute(List<Product> products) {
    final categories = products.map((p) => p.category).toSet().toList();
    return ['Todos', ...categories];
  }
}
