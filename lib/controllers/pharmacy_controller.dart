import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../repositories/product_repository.dart';
import '../usercases/filter_products_usercase.dart';
import '../usercases/get_categories_usecase.dart';

class PharmacyController with ChangeNotifier {
  // === INJEÇÃO DE DEPENDÊNCIAS ===
  final ProductRepository _productRepository;
  final FilterProductsUseCase _filterProductsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  // Construtor recebendo as dependências
  PharmacyController({
    required ProductRepository productRepository,
    required FilterProductsUseCase filterProductsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  }) : _productRepository = productRepository,
       _filterProductsUseCase = filterProductsUseCase,
       _getCategoriesUseCase = getCategoriesUseCase;

  // === ESTADO PRIVADO ===
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<String> _categories = [];
  String _selectedCategory = 'Todos';
  String _searchQuery = '';
  List<Product> _cartItems = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;

  List<Product> get filteredProducts => _filteredProducts;

  List<String> get categories => _categories;

  String get selectedCategory => _selectedCategory;

  String get searchQuery => _searchQuery;

  List<Product> get cartItems => _cartItems;

  int get cartCount => _cartItems.length;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  // === MÉTODO DE INICIALIZAÇÃO ===
  Future<void> initialize() async {
    await _loadProducts();
  }

  // === MÉTODOS PÚBLICOS ===
  Future<void> _loadProducts() async {
    try {
      _setLoading(true);
      _clearError();

      _products = _productRepository.getProducts();
      _categories = _getCategoriesUseCase.execute(_products);
      _applyFilters();
    } catch (e) {
      _setError('Erro ao carregar produtos: $e');
    } finally {
      _setLoading(false);
    }
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

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  Future<void> refreshProducts() async {
    await _loadProducts();
  }

  // === MÉTODOS PRIVADOS ===
  void _applyFilters() {
    _filteredProducts = _filterProductsUseCase.execute(
      _products,
      _selectedCategory,
      _searchQuery,
    );
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
