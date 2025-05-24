import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';
import '../usercases/filter_products_usercase.dart';
import '../usercases/get_categories_usecase.dart';

class PharmacyProvider with ChangeNotifier {
  final ProductRepository _productRepository;
  final FilterProductsUseCase _filterProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  PharmacyProvider({
    required ProductRepository productRepository,
    required FilterProductsUseCase filterProductsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  }) : _productRepository = productRepository,
       _filterProductsUseCase = filterProductsUseCase,
       _getCategoriesUseCase = getCategoriesUseCase {
    _loadProducts();
  }

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  String _selectedCategory = 'Todos';
  String _searchQuery = '';
  List<Product> _cartItems = [];

  List<Product> get products => _products;

  List<Product> get filteredProducts => _filteredProducts;

  List<String> get categories => _categories;

  String get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  List<Product> get cartItems => _cartItems;

  int get cartCount => _cartItems.length;

  void _loadProducts() {
    _products = _productRepository.getProducts();
    _categories = _getCategoriesUseCase.execute(_products);
    _applyFilters();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void _applyFilters() {
    _filteredProducts = _filterProductsUseCase.execute(
      _products,
      _selectedCategory,
      _searchQuery,
    );
  }
}
