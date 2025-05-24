import '../models/product.dart';

abstract class ProductRepository {
  List<Product> getProducts();
}
