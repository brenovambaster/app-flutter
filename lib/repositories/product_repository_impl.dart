import 'package:app1/repositories/product_repository.dart';

import '../models/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  List<Product> getProducts() {
    return const [
      Product(
        id: 1,
        name: 'Paracetamol 500mg',
        price: 9.99,
        image: 'assets/images/paracetamol500.webp',
        category: 'Analgésicos',
      ),
      Product(
        id: 2,
        name: 'Dipirona 1g',
        price: 7.50,
        image: 'assets/images/dipirone1g.webp',
        category: 'Analgésicos',
      ),
      Product(
        id: 3,
        name: 'Vitamina D 1g',
        price: 12.00,
        image: 'assets/images/vitaminad.webp',
        category: 'Suplementos',
      ),
      Product(
        id: 4,
        name: 'Álcool em Gel 500ml',
        price: 15.00,
        image: 'assets/images/alcoolgel500ml.webp',
        category: 'Higiene',
      ),
      Product(
        id: 5,
        name: 'Termômetro Digital',
        price: 25.00,
        image: 'assets/images/termometro.webp',
        category: 'Equipamentos',
      ),
      Product(
        id: 6,
        name: 'Máscara Cirúrgica (50 un.)',
        price: 30.00,
        image: 'assets/images/mascara.webp',
        category: 'Higiene',
      ),
    ];
  }
}
