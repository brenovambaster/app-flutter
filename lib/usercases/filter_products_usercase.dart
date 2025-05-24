import 'package:app1/models/product.dart';

class FilterProductsUseCase {
  List<Product> execute(
    List<Product> products,
    String category,
    String searchQuery,
  ) {
    return products.where((product) {
      final matchesCategory =
          category == 'Todos' || product.category == category;
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
