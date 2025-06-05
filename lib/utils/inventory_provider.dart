import 'package:flutter/material.dart';
import 'package:farm2you/models/product_model.dart';

class InventoryProvider with ChangeNotifier {
  final List<ProductModel> _products = [];
  bool _isLoading = false;

  // Getters
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  // Load products
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _isLoading = false;
    notifyListeners();
  }

  /*
  // Add new product
  Future<bool> addProduct(ProductModel product) async {
    try {
      // Generate ID if it's 0
      if (product.pid == '') {
        product.pid = _getNextId();
      }

      _products.add(product);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  // Delete product
  Future<bool> deleteProduct(int productId) async {
    try {
      _products.removeWhere((product) => product.id == productId);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  // Update product
  Future<bool> updateProduct(ProductModel updatedProduct) async {
    try {
      final index = _products.indexWhere((p) => p.id == updatedProduct.id);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  // Search products
  List<ProductModel> searchProducts(String query) {
    if (query.isEmpty) return _products;

    return _products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Filter by category
  List<ProductModel> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // Get product by ID
  Future<ProductModel?> getProductById(int productId) async {
    try {
      return _products.firstWhere((product) => product.id == productId);
    } catch (e) {
      print('Error getting product by ID: $e');
      return null;
    }
  }

  // Private helper methods
  int _getNextId() {
    if (_products.isEmpty) return 1;
    return _products.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
  }
  */
}
