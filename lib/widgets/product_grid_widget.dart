import 'package:app1/widgets/product_card_widget.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductGridWidget extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAddToCart;
  final Function(Product) onProductTap;

  const ProductGridWidget({
    super.key,
    required this.products,
    required this.onAddToCart,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCardWidget(
              product: product,
              onAddToCart: () => onAddToCart(product),
              onTap: () => onProductTap(product),
            );
          },
        ),
      ),
    );
  }
}
