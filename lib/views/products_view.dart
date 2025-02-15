

import 'package:category_product_listing/views/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import '../services/category_list_services.dart';
import '../models/category_list_model.dart';

// ✅ API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(Dio());
});

// ✅ Product State
class ProductState {
  final List<Product> products;
  final List<Category> categories;
  final String? selectedCategoryId;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final String? errorMessage;

  ProductState({
    required this.products,
    required this.categories,
    required this.selectedCategoryId,
    required this.isLoading,
    required this.isLoadingMore,
    required this.currentPage,
    this.errorMessage,
  });

  ProductState copyWith({
    List<Product>? products,
    List<Category>? categories,
    String? selectedCategoryId,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    String? errorMessage,
  }) {
    return ProductState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ✅ Product Notifier
class ProductNotifier extends StateNotifier<ProductState> {
  final ApiService _apiService;

  ProductNotifier(this._apiService)
      : super(ProductState(
            products: [],
            categories: [],
            selectedCategoryId: null,
            isLoading: true,
            isLoadingMore: false,
            currentPage: 1)) {
    fetchProducts(page: 1);
  }

  Future<void> fetchProducts({String? categoryId, required int page}) async {
    if (page == 1) {
      state = state.copyWith(
          isLoading: true,
          errorMessage: null,
          selectedCategoryId: categoryId,
          currentPage: page);
    } else {
      state = state.copyWith(
          isLoadingMore: true, errorMessage: null, currentPage: page);
    }
    try {
      final response =
          await _apiService.fetchProducts(categoryId: categoryId, page: page);
      state = state.copyWith(
        products: page == 1
            ? response.products
            : [...state.products, ...response.products],
        categories: response.categories.isNotEmpty
            ? response.categories
            : state.categories,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(
          isLoading: false, isLoadingMore: false, errorMessage: e.toString());
    }
  }
}

// ✅ Product Provider
final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ProductNotifier(apiService);
});

class ProductListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Vegetables & Fruits')),
      body: Row(
        children: [
          // 📌 Always Visible Vertical Category List
          CategoryListView(ref),

          // 📌 Product Grid (Right Side)
          Expanded(
            child: productState.isLoading
                ? Center(child: CircularProgressIndicator())
                : productState.errorMessage != null
                    ? Center(child: Text('Error: ${productState.errorMessage}'))
                    : ProductGridView(ref),
          ),
        ],
      ),
    );
  }
}

// ✅ Vertical Category View
Widget CategoryListView(WidgetRef ref) {
  final productState = ref.watch(productProvider);
  return SizedBox(
    width: 100, // Adjust width as needed
    child: ListView.builder(
      itemCount: productState.categories.length,
      itemBuilder: (context, index) {
        final category = productState.categories[index];
        final isSelected = category.id == productState.selectedCategoryId;
        return GestureDetector(
          onTap: () {
            ref
                .read(productProvider.notifier)
                .fetchProducts(categoryId: category.id, page: 1);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue
                        : Colors.green, // Highlight selected category
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl: category.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(category.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// ✅ Product Grid View with "ADD" Button
Widget ProductGridView(WidgetRef ref) {
  final productState = ref.watch(productProvider);
  return NotificationListener<ScrollNotification>(
    onNotification: (ScrollNotification scrollInfo) {
      if (!productState.isLoadingMore &&
          scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
        ref.read(productProvider.notifier).fetchProducts(
            categoryId: productState.selectedCategoryId,
            page: productState.currentPage + 1);
      }
      return true;
    },
    child: GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount:
          productState.products.length + (productState.isLoadingMore ? 1 : 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        if (index == productState.products.length) {
          return Center(child: CircularProgressIndicator());
        }
        final product = productState.products[index];
        return Stack(
          children: [
            InkWell(onTap:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailsView(product:  product,)));
            },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl: product.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.maxQuantity.toString() + " g",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 6, 3, 92))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹ ${product.discountPrice}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            "MRP ₹${product.price}",
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    if (product.status)
                      
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("25% OFF",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                        
                      
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 113,
                right: 8,
                child: Container(
                  // height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        8), // Square-like with 8px rounded corners
                    border: Border.all(
                        color: Colors.green, width: 2), // Green border
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      child: Center(
                        child: Text(
                          "ADD",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )

                // child:
                //         ElevatedButton(
                //               onPressed: () {},
                //               style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(

                //                   borderRadius: BorderRadius.circular(8),

                //                 ),

                //                 textStyle: const TextStyle(color: Colors.white),
                //                 backgroundColor: Colors.white,
                //                 foregroundColor: Colors.green,
                //               ),
                //               child: Text("ADD",style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                //             ),
                ),
          ],
        );
      },
    ),
    //  GridView.builder(
    //   padding: const EdgeInsets.all(8),
    //   itemCount:
    //       productState.products.length + (productState.isLoadingMore ? 1 : 0),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 0.75,
    //     crossAxisSpacing: 8,
    //     mainAxisSpacing: 8,
    //   ),
    //   itemBuilder: (context, index) {
    //     if (index == productState.products.length) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     final product = productState.products[index];
    //     return Card(
    //       shape:
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //       elevation: 4,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(

    //             child: ClipRRect(
    //               borderRadius:
    //                   const BorderRadius.vertical(top: Radius.circular(12)),
    //               child: CachedNetworkImage(

    //                 imageUrl: product.imageUrl,
    //                 width: double.infinity,
    //                 height: 200,

    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               ElevatedButton(
    //                 onPressed: () {},
    //                 style: ElevatedButton.styleFrom(
    //                   textStyle: const TextStyle(color: Colors.white),
    //                   backgroundColor: Colors.white,
    //                   foregroundColor: Colors.green,
    //                 ),
    //                 child: Text("ADD"),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             children: [
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Text(
    //                 product.maxQuantity.toString() + " g",
    //                 style: TextStyle(
    //                     color: const Color.fromARGB(255, 65, 21, 224)),
    //               ),
    //               SizedBox(
    //                 width: 20,
    //               ),
    //               // Text(product.)
    //             ],
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(product.title,
    //                 style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold, )),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               spacing: 5,
    //               children: [Icon(Icons.timer), Text("8 mins")],
    //             ),
    //           ),
    //           Padding(padding: const EdgeInsets.all(8.0),
    //           child: product.status==true? Text("25% OFF", style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600),):Text(product.statusText),),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 10),
    //             child: Row(
    //               children: [
    //                 Text(
    //                   "₹ ${product.discountPrice.toString()}  ",
    //                   style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize:20),
    //                 ),
    //                 Text(
    //                   " MRP ₹${product.price.toString()}",
    //                   style: TextStyle(
    //                       color: Colors.grey,
    //                       fontWeight: FontWeight.bold,
    //                       decoration: TextDecoration.lineThrough,
    //                       fontSize: 10),
    //                 ),
    //               ],
    //             ),

    //           ),

    //           //   Expanded(
    //           //     child: ClipRRect(
    //           //       borderRadius:
    //           //           const BorderRadius.vertical(top: Radius.circular(12)),
    //           //       child: CachedNetworkImage(
    //           //         imageUrl: product.imageUrl,
    //           //         width: double.infinity,
    //           //         fit: BoxFit.cover,
    //           //       ),
    //           //     ),
    //           //   ),
    //           //   Padding(
    //           //     padding: const EdgeInsets.all(8.0),
    //           //     child: Text(product.title,
    //           //         style: const TextStyle(fontWeight: FontWeight.bold)),
    //           //   ),
    //           //   Padding(
    //           //     padding: const EdgeInsets.all(8.0),
    //           //     child: Text(product.price.toString(),
    //           //         style: const TextStyle(fontWeight: FontWeight.bold)),
    //           //   ),
    //           //   Padding(
    //           //     padding: const EdgeInsets.all(8.0),
    //           //     child: ElevatedButton(
    //           //       onPressed: () {},
    //           //       style: ElevatedButton.styleFrom(
    //           //         backgroundColor: Colors.green,
    //           //         foregroundColor: Colors.white,
    //           //       ),
    //           //       child: Text("ADD"),
    //           //     ),
    //           //   ),
    //         ],
    //       ),
    //     );
    //   },
    // ),
  );
}
