class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
