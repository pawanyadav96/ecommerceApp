import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();
  List<ProductModel> products = [];

  List<ProductModel> filteredProducts = [];

  bool isLoading = false;

  bool isPaginationLoading = false;

  bool hasMore = true;

  int limit = 10;

  int skip = 0;

  String selectedCategory = 'All';

  String selectedSort = '';

  String searchQuery = '';

  bool isFetching = false;

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isFetching) return;

    isFetching = true;
    if (isRefresh) {
      skip = 0;
      hasMore = true;
      products.clear();
      filteredProducts.clear();
    }

    if (!hasMore) return;

    if (skip == 0) {
      isLoading = true;
    } else {
      isPaginationLoading = true;
    }

    notifyListeners();

    try {
      final response = await _service.getProducts(limit: limit, skip: skip);

      if (response.isEmpty) {
        hasMore = false;
      } else {
        products.addAll(response);

        skip += limit;
      }

      applyFilters();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;

    isPaginationLoading = false;

    isFetching = false;

    notifyListeners();
  }

  void searchProducts(String value) {
    searchQuery = value;

    applyFilters();
  }

  void filterCategory(String category) {
    selectedCategory = category;

    applyFilters();
  }

  void sortProducts(String sortType) {
    selectedSort = sortType;

    applyFilters();
  }

  void applyFilters() {
    filteredProducts = products.where((product) {
      final matchesSearch = product.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      final matchesCategory = selectedCategory == 'All'
          ? true
          : product.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    if (selectedSort == 'low') {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    }

    if (selectedSort == 'high') {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    }

    if (selectedSort == 'rating') {
      filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
    }

    notifyListeners();
  }
}
