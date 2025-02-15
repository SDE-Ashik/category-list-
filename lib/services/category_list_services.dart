// // // import 'dart:convert';
// // // import 'package:category_product_listing/models/category_list_model.dart';
// // // import 'package:dio/dio.dart';

// // // class ApiService {
// // //   static const String baseUrl = "https://alpha.bytesdelivery.com/api/v3";
// // //   static final Dio _dio = Dio();

// // //   static Future<ProductResponse> fetchProducts(
// // //       {required String categoryId, required int page}) async {
// // //     final String url =
// // //         "$baseUrl/product/category-products/value/${categoryId == 'null' ? 'null' : categoryId}/$page";
// // //     try {
// // //       final response = await _dio.get(url);
// // //       if (response.statusCode == 200) {
// // //         final Map<String, dynamic> data = response.data;
// // //         return ProductResponse.fromJson(data);
// // //       } else {
// // //         throw Exception('Failed to load products');
// // //       }
// // //     } catch (e) {
// // //       throw Exception('Error fetching data: $e');
// // //     }
// // //   }
// // // }

// // import 'package:dio/dio.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../models/category_list_model.dart';

// // // Provider for API service (Better Naming)
// // final apiServiceProvider = Provider<ApiService>((ref) => ApiService(Dio()));

// // class ApiService {
// //   static const String baseUrl = "https://alpha.bytesdelivery.com/api/v3";
// //   final Dio _dio; // Inject Dio for better testing & flexibility

// //   ApiService(this._dio);

// //   Future<ProductResponse> fetchProducts(
// //       {String? categoryId, required int page}) async {
// //     final String url =
// //         "$baseUrl/product/category-products/value/${categoryId ?? 'null'}/$page";

// //     try {
// //       final response = await _dio.get(url);

// //       if (response.statusCode == 200) {
// //         return ProductResponse.fromJson(response.data);
// //       } else {
// //         throw ApiException('Failed to load products', response.statusCode,
// //             response.statusMessage);
// //       }
// //     } on DioException catch (e) {
// //       throw ApiException(
// //           'Dio Error', e.response?.statusCode, e.response?.data.toString());
// //     } catch (e) {
// //       throw ApiException('Unexpected error', null, e.toString());
// //     }
// //   }
// // }

// // // Custom API Exception
// // class ApiException implements Exception {
// //   final String message;
// //   final int? statusCode;
// //   final String? details;

// //   ApiException(this.message, this.statusCode, this.details);

// //   @override
// //   String toString() {
// //     return "ApiException: $message (Status Code: $statusCode) \nDetails: $details";
// //   }
// // }

// import 'package:dio/dio.dart';
// import '../models/category_list_model.dart';

// class ApiService {
//   static const String baseUrl = "https://alpha.bytesdelivery.com/api/v3";
//   final Dio _dio;

//   ApiService(this._dio);

//   // Fetch Products with Pagination
//   Future<ProductResponse> fetchProducts(
//       {String? categoryId, required int page}) async {
//     final String url =
//         "$baseUrl/product/category-products/value/${categoryId ?? 'null'}/$page";

//     try {
//       final response = await _dio.get(url);
//       if (response.statusCode == 200) {
//         return ProductResponse.fromJson(response.data);
//       } else {
//         throw Exception('Failed to load products');
//       }
//     } on DioException catch (e) {
//       throw Exception('Dio Error: ${e.response?.data}');
//     } catch (e) {
//       throw Exception('Unexpected error: $e');
//     }
//   }

//   // Fetch Categories
//   Future<List<Category>> fetchCategories() async {
//     final String url = "$baseUrl/product/categories";

//     try {
//       final response = await _dio.get(url);
//       if (response.statusCode == 200) {
//         return (response.data['data']['categories'] as List)
//             .map((json) => Category.fromJson(json))
//             .toList();
//       } else {
//         throw Exception('Failed to load categories');
//       }
//     } catch (e) {
//       throw Exception('Error fetching categories: $e');
//     }
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/category_list_model.dart';

// // ✅ Riverpod Provider for API Service
// final apiServiceProvider = Provider<ApiService>((ref) {
//   return ApiService(Dio());
// });

// class ApiService {
//   static const String baseUrl = "https://alpha.bytesdelivery.com/api/v3";
//   final Dio _dio;

//   ApiService(this._dio);

//   // ✅ Fetch Products & Categories with Pagination
//   Future<ProductResponse> fetchProducts(
//       {String? categoryId, required int page}) async {
//     final String url = 
//     // "https://alpha.bytesdelivery.com/api/v3/product/category-products/value/643c775bff1bf0b233a1b45e/1";
//     "$baseUrl/product/category-products/value/${categoryId ?? 'null'}/$page";
//     print(url);

//     try {
//       final response = await _dio.get(url);

//       if (response.statusCode == 200) {
//         print("hi");
//         print("output kitti");
//         return ProductResponse.fromJson(response.data);
//       } else {
//         throw ApiException("Failed to load products", response.statusCode,
//             response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw ApiException(
//           "Dio Error", e.response?.statusCode, e.response?.data.toString());
//     } catch (e) {
//       throw ApiException("Unexpected error", null, e.toString());
//     }
//   }
// }

// // ✅ Custom Exception for API Handling
// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;
//   final String? details;

//   ApiException(this.message, this.statusCode, this.details);

//   @override
//   String toString() {
//     return "ApiException: $message (Status Code: $statusCode) \nDetails: $details";
//   }
// }


// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/category_list_model.dart';

// // ✅ Riverpod Provider for API Service
// final apiServiceProvider = Provider<ApiService>((ref) {
//   return ApiService(Dio());
// });

// class ApiService {
//   static const String baseUrl = "https://alpha.bytesdelivery.com/api/v3";
//   final Dio _dio;

//   ApiService(this._dio);

//   // ✅ Fetch Products & Categories with Pagination
//   Future<ProductResponse> fetchProducts(
//       {String? categoryId, required int page}) async {
//     final String url =
//         "$baseUrl/product/category-products/value/${categoryId ?? 'null'}/$page";

//     print("🟡 API Request: $url"); // Debugging

//     try {
//       final response = await _dio.get(url);

//       print(
//           "🟢 API Response Received - Status Code: ${response.statusCode}"); // Debugging

//       if (response.statusCode == 200) {
//         print(
//             "✅ Products Fetched: ${response.data}"); // Debugging (limit logging large responses)
//         return ProductResponse.fromJson(response.data);
//       } else {
//         print(
//             "🔴 API Error: ${response.statusCode} - ${response.statusMessage}");
//         throw ApiException("Failed to load products", response.statusCode,
//             response.statusMessage);
//       }
//     } on DioException catch (e) {
//       print("🔴 Dio Error: ${e.response?.statusCode} - ${e.response?.data}");
//       throw ApiException("Dio Error", e.response?.statusCode ?? 500,
//           e.response?.data?.toString() ?? "Unknown error occurred");
//     } catch (e) {
//       print("🔴 Unexpected API Error: $e");
//       throw ApiException("Unexpected error", null, e.toString());
//     }
//   }
// }

// // ✅ Custom Exception for API Handling
// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;
//   final String? details;

//   ApiException(this.message, this.statusCode, this.details);

//   @override
//   String toString() {
//     return "❌ ApiException: $message (Status Code: ${statusCode ?? 'Unknown'})\nDetails: $details";
//   }
// }


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_list_model.dart';

// ✅ Riverpod Provider for API Service
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(Dio());
});

class ApiService {
  static const String baseUrl = "https://alpha.bytesdelivery.com/api/v3";
  final Dio _dio;

  ApiService(this._dio);

  // ✅ Fetch Categories
  Future<List<Category>> fetchCategories() async {
    final String url = "$baseUrl/product/category-products/value/'null'1}/";
    print("🟡 API Request (Categories): $url");

    try {
      final response = await _dio.get(url);

      print(
          "🟢 API Response Received (Categories) - Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("✅ Categories Fetched: ${response.data}");
        return (response.data['data']['categories'] as List<dynamic>?)
                ?.map((item) => Category.fromJson(item))
                .toList() ??
            [];
      } else {
        print(
            "🔴 API Error (Categories): ${response.statusCode} - ${response.statusMessage}");
        throw ApiException("Failed to load categories", response.statusCode,
            response.statusMessage);
      }
    } on DioException catch (e) {
      print(
          "🔴 Dio Error (Categories): ${e.response?.statusCode} - ${e.response?.data}");
      throw ApiException("Dio Error", e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? "Unknown error occurred");
    } catch (e) {
      print("🔴 Unexpected API Error (Categories): $e");
      throw ApiException("Unexpected error", null, e.toString());
    }
  }

  // ✅ Fetch Products with Pagination
  Future<ProductResponse> fetchProducts(
      {String? categoryId, required int page}) async {
    final String url =
        "$baseUrl/product/category-products/value/${categoryId ?? 'null'}/$page";

    print("🟡 API Request (Products): $url");

    try {
      final response = await _dio.get(url);

      print(
          "🟢 API Response Received (Products) - Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("✅ Products Fetched: ${response.data}");
        return ProductResponse.fromJson(response.data);
      } else {
        print(
            "🔴 API Error (Products): ${response.statusCode} - ${response.statusMessage}");
        throw ApiException("Failed to load products", response.statusCode,
            response.statusMessage);
      }
    } on DioException catch (e) {
      print(
          "🔴 Dio Error (Products): ${e.response?.statusCode} - ${e.response?.data}");
      throw ApiException("Dio Error", e.response?.statusCode ?? 500,
          e.response?.data?.toString() ?? "Unknown error occurred");
    } catch (e) {
      print("🔴 Unexpected API Error (Products): $e");
      throw ApiException("Unexpected error", null, e.toString());
    }
  }
}

// ✅ Custom Exception for API Handling
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? details;

  ApiException(this.message, this.statusCode, this.details);

  @override
  String toString() {
    return "❌ ApiException: $message (Status Code: ${statusCode ?? 'Unknown'})\nDetails: $details";
  }
}
