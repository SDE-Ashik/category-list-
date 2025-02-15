


import 'package:category_product_listing/services/category_list_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/category_list_model.dart';


// ✅ API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(Dio());
});

// ✅ Product State
class ProductState {
  final List<Product> products;
  final List<Category> categories;
  final bool isLoading;
  final String? errorMessage;

  ProductState({
    required this.products,
    required this.categories,
    required this.isLoading,
    this.errorMessage,
  });

  ProductState copyWith({
    List<Product>? products,
    List<Category>? categories,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ✅ Product Notifier
class ProductNotifier extends StateNotifier<ProductState> {
  final ApiService _apiService;

  ProductNotifier(this._apiService)
      : super(ProductState(products: [], categories: [], isLoading: false));

  Future<void> fetchProducts({String? categoryId, required int page}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response =
          await _apiService.fetchProducts(categoryId: categoryId, page: page);
      state = state.copyWith(
        products: response.products,
        categories: response.categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

// ✅ Product Provider
final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ProductNotifier(apiService);
});
