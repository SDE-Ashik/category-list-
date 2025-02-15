// // // // // // import 'package:category_product_listing/services/category_list_services.dart';
// // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // // // import '../models/category_list_model.dart';

// // // // // // // Product State: Handles loading, success, and error states
// // // // // // class ProductState {
// // // // // //   final bool isLoading;
// // // // // //   final List<Product>? products;
// // // // // //   final String? error;

// // // // // //   ProductState({this.isLoading = false, this.products, this.error});
// // // // // // }

// // // // // // // Product Notifier: Manages product fetching
// // // // // // class ProductNotifier extends StateNotifier<ProductState> {
// // // // // //   final ApiService apiService;

// // // // // //   ProductNotifier({required this.apiService}) : super(ProductState());

// // // // // //   Future<void> fetchProducts({String categoryId = 'null', int page = 1}) async {
// // // // // //     state = ProductState(isLoading: true);
// // // // // //     try {
// // // // // //       final response =
// // // // // //           await apiService.fetchProducts(categoryId: categoryId, page: page);
// // // // // //       state = ProductState(products: response.products);
// // // // // //     } catch (e) {
// // // // // //       state = ProductState(error: e.toString());
// // // // // //     }
// // // // // //   }
// // // // // // }

// // // // // // // Product Provider using StateNotifierProvider
// // // // // // final productProvider =
// // // // // //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// // // // // //   final apiService = ref.watch(apiServiceProvider);
// // // // // //   return ProductNotifier(apiService: apiService);
// // // // // // });

// // // // // import 'package:category_product_listing/services/category_list_services.dart';
// // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // // // import '../models/category_list_model.dart';

// // // // // // State class for managing API response
// // // // // class ProductState {
// // // // //   final bool isLoading;
// // // // //   final List<Product>? products;
// // // // //   final List<Category>? categories;
// // // // //   final String? error;

// // // // //   ProductState(
// // // // //       {this.isLoading = false, this.products, this.categories, this.error});
// // // // // }

// // // // // // Notifier to fetch products from API
// // // // // class ProductNotifier extends StateNotifier<ProductState> {
// // // // //   final ApiService apiService;

// // // // //   ProductNotifier({required this.apiService}) : super(ProductState());

// // // // //   Future<void> fetchProducts({String? categoryId, int page = 1}) async {
// // // // //     state = ProductState(isLoading: true);
// // // // //     try {
// // // // //       final response =
// // // // //           await apiService.fetchProducts(categoryId: categoryId, page: page);
// // // // //       state = ProductState(
// // // // //           products: response.products, categories: response.categories);
// // // // //     } catch (e) {
// // // // //       state = ProductState(error: e.toString());
// // // // //     }
// // // // //   }
// // // // // }

// // // // // // Provider for ProductNotifier
// // // // // final productProvider =
// // // // //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// // // // //   final apiService = ref.watch(apiServiceProvider);
// // // // //   return ProductNotifier(apiService: apiService);
// // // // // });

// // // // import 'package:category_product_listing/services/category_list_services.dart';
// // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // import 'package:dio/dio.dart';

// // // // import '../models/category_list_model.dart';

// // // // // API Service Provider
// // // // final apiServiceProvider = Provider<ApiService>((ref) => ApiService(Dio()));

// // // // // Product State (Pagination)
// // // // class ProductState {
// // // //   final bool isLoading;
// // // //   final List<Product> products;
// // // //   final int page;
// // // //   final bool hasMore;
// // // //   final String? error;

// // // //   ProductState({
// // // //     this.isLoading = false,
// // // //     this.products = const [],
// // // //     this.page = 1,
// // // //     this.hasMore = true,
// // // //     this.error,
// // // //   });

// // // //   ProductState copyWith({
// // // //     bool? isLoading,
// // // //     List<Product>? products,
// // // //     int? page,
// // // //     bool? hasMore,
// // // //     String? error,
// // // //   }) {
// // // //     return ProductState(
// // // //       isLoading: isLoading ?? this.isLoading,
// // // //       products: products ?? this.products,
// // // //       page: page ?? this.page,
// // // //       hasMore: hasMore ?? this.hasMore,
// // // //       error: error,
// // // //     );
// // // //   }
// // // // }

// // // // // Product Notifier
// // // // class ProductNotifier extends StateNotifier<ProductState> {
// // // //   final ApiService apiService;

// // // //   ProductNotifier({required this.apiService}) : super(ProductState());

// // // //   Future<void> fetchProducts({String? categoryId}) async {
// // // //     if (!state.hasMore) return;

// // // //     state = state.copyWith(isLoading: true);
// // // //     try {
// // // //       final response = await apiService.fetchProducts(
// // // //           categoryId: categoryId, page: state.page);
// // // //       state = state.copyWith(
// // // //         products: [...state.products, ...response.products],
// // // //         page: state.page + 1,
// // // //         hasMore: response.products.isNotEmpty,
// // // //         isLoading: false,
// // // //       );
// // // //     } catch (e) {
// // // //       state = state.copyWith(error: e.toString(), isLoading: false);
// // // //     }
// // // //   }
// // // // }

// // // // // Provider for ProductNotifier
// // // // final productProvider =
// // // //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// // // //   final apiService = ref.watch(apiServiceProvider);
// // // //   return ProductNotifier(apiService: apiService);
// // // // });

// // // // // Category Provider
// // // // final categoryProvider = FutureProvider<List<Category>>((ref) async {
// // // //   final apiService = ref.watch(apiServiceProvider);
// // // //   return apiService.fetchCategories();
// // // // });


// // import 'package:category_product_listing/services/category_list_services.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import '../models/category_list_model.dart';

// // // ✅ Product State: Manages loading, success, and error states
// // class ProductState {
// //   final bool isLoading;
// //   final List<Product> products;
// //   final List<Category> categories;
// //   final int page;
// //   final bool hasMore;
// //   final String? error;

// //   ProductState({
// //     this.isLoading = false,
// //     this.products = const [],
// //     this.categories = const [],
// //     this.page = 1,
// //     this.hasMore = true,
// //     this.error,
// //   });

// //   ProductState copyWith({
// //     bool? isLoading,
// //     List<Product>? products,
// //     List<Category>? categories,
// //     int? page,
// //     bool? hasMore,
// //     String? error,
// //   }) {
// //     return ProductState(
// //       isLoading: isLoading ?? this.isLoading,
// //       products: products ?? this.products,
// //       categories: categories ?? this.categories,
// //       page: page ?? this.page,
// //       hasMore: hasMore ?? this.hasMore,
// //       error: error,
// //     );
// //   }
// // }

// // // ✅ Product Notifier: Fetches Products & Categories
// // class ProductNotifier extends StateNotifier<ProductState> {
// //   final ApiService apiService;

// //   ProductNotifier({required this.apiService}) : super(ProductState());

// //   // 🔹 Fetch Products & Categories (Handles Pagination)
// //   Future<void> fetchProducts({String? categoryId}) async {
// //     if (!state.hasMore) return;

// //     state = state.copyWith(isLoading: true, error: null);
// //     try {
// //       final response = await apiService.fetchProducts(
// //           categoryId: categoryId, page: state.page);

// //       state = state.copyWith(
// //         products: [
// //           ...state.products,
// //           ...response.products
// //         ], // Append new products
// //         categories: response.categories, // Update categories
// //         page: state.page + 1, // Increase page for next fetch
// //         hasMore:
// //             response.products.isNotEmpty, // Stop pagination if no more products
// //         isLoading: false,
// //       );
// //     } catch (e) {
// //       state = state.copyWith(error: e.toString(), isLoading: false);
// //     }
// //   }
// // }

// // // ✅ Riverpod Provider for ProductNotifier
// // final productProvider =
// //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// //   final apiService = ref.watch(apiServiceProvider);
// //   return ProductNotifier(apiService: apiService);
// // });

// // import 'package:category_product_listing/services/category_list_services.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import '../models/category_list_model.dart';

// // // ✅ Product State
// // class ProductState {
// //   final bool isLoading;
// //   final List<Product> products;
// //   final List<Category> categories;
// //   final int page;
// //   final bool hasMore;
// //   final String? error;

// //   ProductState({
// //     this.isLoading = false,
// //     this.products = const [],
// //     this.categories = const [],
// //     this.page = 1,
// //     this.hasMore = true,
// //     this.error,
// //   });

// //   ProductState copyWith({
// //     bool? isLoading,
// //     List<Product>? products,
// //     List<Category>? categories,
// //     int? page,
// //     bool? hasMore,
// //     String? error,
// //   }) {
// //     return ProductState(
// //       isLoading: isLoading ?? this.isLoading,
// //       products: products ?? this.products,
// //       categories: categories ?? this.categories,
// //       page: page ?? this.page,
// //       hasMore: hasMore ?? this.hasMore,
// //       error: error,
// //     );
// //   }
// // }

// // // ✅ Product Notifier: Fetches Products & Categories
// // class ProductNotifier extends StateNotifier<ProductState> {
// //   final ApiService apiService;

// //   ProductNotifier({required this.apiService}) : super(ProductState());

// //   // 🔹 Fetch Products & Categories (Handles Pagination)
// //   Future<void> fetchProducts({String? categoryId, bool reset = false}) async {
// //     if (!state.hasMore && !reset) return;

// //     state = state.copyWith(isLoading: true, error: null);

// //     try {
// //       // ✅ If category changes, reset products list
// //       if (reset) {
// //         state = state.copyWith(products: [], page: 1, hasMore: true);
// //       }

// //       final response = await apiService.fetchProducts(
// //         categoryId: categoryId,
// //         page: state.page,
// //       );

// //       state = state.copyWith(
// //         products: [
// //           ...state.products,
// //           ...response.products
// //         ], // Append new products
// //         categories: response.categories, // Update categories
// //         page: state.page + 1, // Increase page for next fetch
// //         hasMore:
// //             response.products.isNotEmpty, // Stop pagination if no more products
// //         isLoading: false,
// //       );
// //     } catch (e) {
// //       state = state.copyWith(error: e.toString(), isLoading: false);
// //     }
// //   }
// // }

// // // ✅ Riverpod Provider for ProductNotifier
// // final productProvider =
// //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// //   final apiService = ref.watch(apiServiceProvider);
// //   return ProductNotifier(apiService: apiService);
// // });


// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/category_list_model.dart';
// import '../services/category_list_services.dart';

// // ✅ Product State
// class ProductState {
//   final bool isLoading;
//   final List<Product> products;
//   final List<Category> categories;
//   final int page;
//   final bool hasMore;
//   final String? error;

//   ProductState({
//     this.isLoading = false,
//     this.products = const [],
//     this.categories = const [],
//     this.page = 1,
//     this.hasMore = true,
//     this.error,
//   });

//   ProductState copyWith({
//     bool? isLoading,
//     List<Product>? products,
//     List<Category>? categories,
//     int? page,
//     bool? hasMore,
//     String? error,
//   }) {
//     return ProductState(
//       isLoading: isLoading ?? this.isLoading,
//       products: products ?? this.products,
//       categories: categories ?? this.categories,
//       page: page ?? this.page,
//       hasMore: hasMore ?? this.hasMore,
//       error: error,
//     );
//   }
// }

// // ✅ Product Notifier: Fetches Products & Categories
// class ProductNotifier extends StateNotifier<AsyncValue<ProductState>> {
//   final ApiService apiService;

//   ProductNotifier({required this.apiService})
//       : super(AsyncValue.data(ProductState()));

//   // 🔹 Fetch Products & Categories (Handles Pagination)
//   Future<void> fetchProducts({String? categoryId, bool reset = false}) async {
//     state = const AsyncValue.loading();

//     try {
//       final currentState = state.asData?.value ?? ProductState();

//       // ✅ If category changes, reset products list
//       if (reset) {
//         state = AsyncValue.data(
//             ProductState(products: [], page: 1, hasMore: true));
//       }

//       final response = await apiService.fetchProducts(
//         categoryId: categoryId,
//         page: reset ? 1 : currentState.page,
//       );

//       final newState = currentState.copyWith(
//         products: reset
//             ? response.products
//             : [
//                 ...currentState.products,
//                 ...response.products
//               ], // Append new products
//         categories: response.categories, // Update categories
//         page: currentState.page + 1, // Increase page for next fetch
//         hasMore:
//             response.products.isNotEmpty, // Stop pagination if no more products
//         isLoading: false,
//         error: null,
//       );

//       state = AsyncValue.data(newState);
//     } catch (e) {
//       state = AsyncValue.data(
//           currentState.copyWith(isLoading: false, error: e.toString()));
//     }
//   }
// }

// // ✅ Riverpod Provider for ProductNotifier
// final productProvider =
//     StateNotifierProvider<ProductNotifier, AsyncValue<ProductState>>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return ProductNotifier(apiService: apiService);
// });


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
