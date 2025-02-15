
class Product {
  final String id;
  final String title;
  final double price;
  final double discountPrice;
  final int quantity;
  final int maxQuantity;
  final String imageUrl;
  final bool status;
  final String statusText;
  final String type;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.quantity,
    required this.maxQuantity,
    required this.imageUrl,
    required this.status,
    required this.statusText,
    required this.type,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'No Title',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPrice: (json['discountPrice'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      maxQuantity: json['maxQuantity'] ?? 0,
      imageUrl: (json['image'] as List<dynamic>?)?.isNotEmpty == true
          ? json['image'][0]['url']
          : 'https://via.placeholder.com/150', // ✅ Default image to prevent crash
      status: json['status'] ?? false,
      statusText: json['statusText'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

// ✅ Category Model
class Category {
  final String id;
  final String title;
  final String imageUrl;
  final bool isSelected;

  Category({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isSelected,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'No Title',
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150',
      isSelected: json['isSelected'] ?? false,
    );
  }
}

// ✅ Product Response Model (Full API Response)
class ProductResponse {
  final bool success;
  final String title;
  final String status;
  final List<Product> products;
  final List<Category> categories;
  final String message;

  ProductResponse({
    required this.success,
    required this.title,
    required this.status,
    required this.products,
    required this.categories,
    required this.message,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'] ?? false,
      title: json['data']['title'] ?? 'No Title',
      status: json['data']['status'] ?? '',
      products: (json['data']['products'] as List<dynamic>?)
              ?.map((item) => Product.fromJson(item))
              .toList() ??
          [], // ✅ Prevent null list
      categories: (json['data']['categories'] as List<dynamic>?)
              ?.map((item) => Category.fromJson(item))
              .toList() ??
          [], // ✅ Prevent null list
      message: json['msg'] ?? '',
    );
  }
}
