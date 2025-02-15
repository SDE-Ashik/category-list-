// // // // // // // // // // // import 'package:category_product_listing/providers/product_notifer.dart';
// // // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // // // // // // // // // import '../models/category_list_model.dart';

// // // // // // // // // // // class ProductScreen extends ConsumerWidget {
// // // // // // // // // // //   const ProductScreen({super.key});

// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // // // // // // // // //     final productState = ref.watch(productProvider);

// // // // // // // // // // //     return Scaffold(
// // // // // // // // // // //       appBar: AppBar(title: const Text("Products")),
// // // // // // // // // // //       body: productState.isLoading
// // // // // // // // // // //           ? const Center(child: CircularProgressIndicator())
// // // // // // // // // // //           : productState.error != null
// // // // // // // // // // //               ? Center(child: Text("Error: ${productState.error}"))
// // // // // // // // // // //               : ListView.builder(
// // // // // // // // // // //                   itemCount: productState.products?.length ?? 0,
// // // // // // // // // // //                   itemBuilder: (context, index) {
// // // // // // // // // // //                     Product product = productState.products![index];
// // // // // // // // // // //                     return ListTile(
// // // // // // // // // // //                       leading:
// // // // // // // // // // //                           Image.network(product.imageUrl), // Ensure valid URLs
// // // // // // // // // // //                       title: Text(product.title),
// // // // // // // // // // //                       subtitle: Text("₹${product.price}"),
// // // // // // // // // // //                     );
// // // // // // // // // // //                   },
// // // // // // // // // // //                 ),
// // // // // // // // // // //       floatingActionButton: FloatingActionButton(
// // // // // // // // // // //         onPressed: () {
// // // // // // // // // // //           ref
// // // // // // // // // // //               .read(productProvider.notifier)
// // // // // // // // // // //               .fetchProducts(categoryId: 'null', page: 1);
// // // // // // // // // // //         },
// // // // // // // // // // //         tooltip: 'Reload',
// // // // // // // // // // //         child: const Icon(Icons.refresh),
// // // // // // // // // // //       ),
// // // // // // // // // // //     );
// // // // // // // // // // //   }
// // // // // // // // // // // }

// // // // // // // // // // import 'package:category_product_listing/providers/product_notifer.dart';
// // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // // // // // // // // class ProductScreen extends ConsumerStatefulWidget {
// // // // // // // // // //   const ProductScreen({super.key});

// // // // // // // // // //   @override
// // // // // // // // // //   _ProductScreenState createState() => _ProductScreenState();
// // // // // // // // // // }

// // // // // // // // // // class _ProductScreenState extends ConsumerState<ProductScreen> {
// // // // // // // // // //   late ScrollController _scrollController;
// // // // // // // // // //   String? selectedCategoryId;

// // // // // // // // // //   @override
// // // // // // // // // //   void initState() {
// // // // // // // // // //     super.initState();
// // // // // // // // // //     _scrollController = ScrollController()..addListener(_scrollListener);
// // // // // // // // // //     ref.read(productProvider.notifier).fetchProducts();
// // // // // // // // // //   }

// // // // // // // // // //   void _scrollListener() {
// // // // // // // // // //     if (_scrollController.position.pixels >=
// // // // // // // // // //         _scrollController.position.maxScrollExtent) {
// // // // // // // // // //       ref
// // // // // // // // // //           .read(productProvider.notifier)
// // // // // // // // // //           .fetchProducts(categoryId: selectedCategoryId);
// // // // // // // // // //     }
// // // // // // // // // //   }

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     final productState = ref.watch(productProvider);
// // // // // // // // // //     final categoryState = ref.watch(categoryProvider);

// // // // // // // // // //     return Scaffold(
// // // // // // // // // //       appBar: AppBar(title: const Text("Vegetables & Fruits")),
// // // // // // // // // //       body: Column(
// // // // // // // // // //         children: [
// // // // // // // // // //           // Categories (Scrollable Row)
// // // // // // // // // //           categoryState.when(
// // // // // // // // // //             data: (categories) => SizedBox(
// // // // // // // // // //               height: 80,
// // // // // // // // // //               child: ListView.builder(
// // // // // // // // // //                 scrollDirection: Axis.horizontal,
// // // // // // // // // //                 itemCount: categories.length,
// // // // // // // // // //                 itemBuilder: (context, index) {
// // // // // // // // // //                   final category = categories[index];
// // // // // // // // // //                   final isSelected = category.id == selectedCategoryId;
// // // // // // // // // //                   return GestureDetector(
// // // // // // // // // //                     onTap: () {
// // // // // // // // // //                       setState(() {
// // // // // // // // // //                         selectedCategoryId = category.id;
// // // // // // // // // //                       });
// // // // // // // // // //                       ref
// // // // // // // // // //                           .read(productProvider.notifier)
// // // // // // // // // //                           .fetchProducts(categoryId: category.id);
// // // // // // // // // //                     },
// // // // // // // // // //                     child: Container(
// // // // // // // // // //                       padding: const EdgeInsets.all(10),
// // // // // // // // // //                       margin: const EdgeInsets.symmetric(horizontal: 5),
// // // // // // // // // //                       decoration: BoxDecoration(
// // // // // // // // // //                         color: isSelected ? Colors.green : Colors.grey[300],
// // // // // // // // // //                         borderRadius: BorderRadius.circular(20),
// // // // // // // // // //                       ),
// // // // // // // // // //                       child: Column(
// // // // // // // // // //                         children: [
// // // // // // // // // //                           Image.network(category.imageUrl,
// // // // // // // // // //                               height: 40, width: 40, fit: BoxFit.cover),
// // // // // // // // // //                           Text(category.title,
// // // // // // // // // //                               style: const TextStyle(fontSize: 12)),
// // // // // // // // // //                         ],
// // // // // // // // // //                       ),
// // // // // // // // // //                     ),
// // // // // // // // // //                   );
// // // // // // // // // //                 },
// // // // // // // // // //               ),
// // // // // // // // // //             ),
// // // // // // // // // //             loading: () => const Center(child: CircularProgressIndicator()),
// // // // // // // // // //             error: (err, _) => Center(child: Text("Error: $err")),
// // // // // // // // // //           ),

// // // // // // // // // //           // Products Grid (Pagination)
// // // // // // // // // //           Expanded(
// // // // // // // // // //             child: GridView.builder(
// // // // // // // // // //               controller: _scrollController,
// // // // // // // // // //               padding: const EdgeInsets.all(8),
// // // // // // // // // //               itemCount: productState.products.length +
// // // // // // // // // //                   (productState.isLoading ? 1 : 0),
// // // // // // // // // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // // // // //                 crossAxisCount: 2,
// // // // // // // // // //                 childAspectRatio: 0.75,
// // // // // // // // // //                 crossAxisSpacing: 8,
// // // // // // // // // //                 mainAxisSpacing: 8,
// // // // // // // // // //               ),
// // // // // // // // // //               itemBuilder: (context, index) {
// // // // // // // // // //                 if (index == productState.products.length) {
// // // // // // // // // //                   return const Center(child: CircularProgressIndicator());
// // // // // // // // // //                 }
// // // // // // // // // //                 final product = productState.products[index];
// // // // // // // // // //                 return Card(
// // // // // // // // // //                   child: Column(
// // // // // // // // // //                     children: [
// // // // // // // // // //                       Image.network(product.imageUrl,
// // // // // // // // // //                           height: 100, fit: BoxFit.cover),
// // // // // // // // // //                       Text(product.title,
// // // // // // // // // //                           style: const TextStyle(fontWeight: FontWeight.bold)),
// // // // // // // // // //                       Text("₹${product.price}",
// // // // // // // // // //                           style: const TextStyle(color: Colors.green)),
// // // // // // // // // //                       ElevatedButton(
// // // // // // // // // //                           onPressed: () {}, child: const Text("ADD")),
// // // // // // // // // //                     ],
// // // // // // // // // //                   ),
// // // // // // // // // //                 );
// // // // // // // // // //               },
// // // // // // // // // //             ),
// // // // // // // // // //           ),
// // // // // // // // // //         ],
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // import 'package:carousel_slider/carousel_slider.dart';
// // // // // // // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // // // // // // class ProductScreen extends StatefulWidget {
// // // // // // // // // //   const ProductScreen({super.key});

// // // // // // // // // //   @override
// // // // // // // // // //   _ProductScreenState createState() => _ProductScreenState();
// // // // // // // // // // }

// // // // // // // // // // class _ProductScreenState extends State<ProductScreen> {
// // // // // // // // // //   int selectedCategoryIndex = 0;

// // // // // // // // // //   // Dummy Categories
// // // // // // // // // //   final List<Map<String, String>> categories = [
// // // // // // // // // //     {'title': 'All', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // // //     {'title': 'Banana', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // // //     {'title': 'Apple', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // // //     {'title': 'Oranges', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // // //     {'title': 'Grapes', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // // //   ];

// // // // // // // // // //   // Dummy Products
// // // // // // // // // //   final List<Map<String, String>> products = [
// // // // // // // // // //     {
// // // // // // // // // //       'title': 'Banana (Robusta)',
// // // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // // //       'price': '₹35',
// // // // // // // // // //       'mrp': '₹48'
// // // // // // // // // //     },
// // // // // // // // // //     {
// // // // // // // // // //       'title': 'Nendran Banana',
// // // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // // //       'price': '₹60',
// // // // // // // // // //       'mrp': '₹75'
// // // // // // // // // //     },
// // // // // // // // // //     {
// // // // // // // // // //       'title': 'Green Apple',
// // // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // // //       'price': '₹120',
// // // // // // // // // //       'mrp': '₹150'
// // // // // // // // // //     },
// // // // // // // // // //     {
// // // // // // // // // //       'title': 'Red Grapes',
// // // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // // //       'price': '₹80',
// // // // // // // // // //       'mrp': '₹100'
// // // // // // // // // //     },
// // // // // // // // // //   ];

// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return Scaffold(
// // // // // // // // // //       appBar: AppBar(title: const Text("Vegetables & Fruits")),
// // // // // // // // // //       body: Column(
// // // // // // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // // // //         children: [
// // // // // // // // // //           // Category Slider
// // // // // // // // // //           Padding(
// // // // // // // // // //             padding: const EdgeInsets.symmetric(vertical: 10),
// // // // // // // // // //             child: CarouselSlider(

// // // // // // // // // //               options: CarouselOptions(
// // // // // // // // // //                 height: 80,
// // // // // // // // // //                 enableInfiniteScroll: true,
// // // // // // // // // //                 viewportFraction: 0.25,
// // // // // // // // // //               ),
// // // // // // // // // //               items: categories.asMap().entries.map((entry) {
// // // // // // // // // //                 int index = entry.key;
// // // // // // // // // //                 var category = entry.value;
// // // // // // // // // //                 bool isSelected = selectedCategoryIndex == index;

// // // // // // // // // //                 return GestureDetector(
// // // // // // // // // //                   onTap: () {
// // // // // // // // // //                     setState(() {
// // // // // // // // // //                       selectedCategoryIndex = index;
// // // // // // // // // //                     });
// // // // // // // // // //                   },
// // // // // // // // // //                   child: Column(
// // // // // // // // // //                     children: [
// // // // // // // // // //                       Container(
// // // // // // // // // //                         padding: const EdgeInsets.all(8),
// // // // // // // // // //                         decoration: BoxDecoration(
// // // // // // // // // //                           color: isSelected ? Colors.green : Colors.grey[300],
// // // // // // // // // //                           borderRadius: BorderRadius.circular(50),
// // // // // // // // // //                         ),
// // // // // // // // // //                         child: ClipRRect(
// // // // // // // // // //                           borderRadius: BorderRadius.circular(25),
// // // // // // // // // //                           child: CachedNetworkImage(
// // // // // // // // // //                             imageUrl: category['image']!,
// // // // // // // // // //                             width: 50,
// // // // // // // // // //                             height: 50,
// // // // // // // // // //                             fit: BoxFit.cover,
// // // // // // // // // //                           ),
// // // // // // // // // //                         ),
// // // // // // // // // //                       ),
// // // // // // // // // //                       const SizedBox(height: 5),
// // // // // // // // // //                       Text(category['title']!,
// // // // // // // // // //                           style: TextStyle(
// // // // // // // // // //                               fontSize: 12,
// // // // // // // // // //                               fontWeight: isSelected
// // // // // // // // // //                                   ? FontWeight.bold
// // // // // // // // // //                                   : FontWeight.normal)),
// // // // // // // // // //                     ],
// // // // // // // // // //                   ),
// // // // // // // // // //                 );
// // // // // // // // // //               }).toList(),
// // // // // // // // // //             ),
// // // // // // // // // //           ),

// // // // // // // // // //           // Product Grid
// // // // // // // // // //           Expanded(
// // // // // // // // // //             child: GridView.builder(
// // // // // // // // // //               padding: const EdgeInsets.all(8),
// // // // // // // // // //               itemCount: products.length,
// // // // // // // // // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // // // // //                 crossAxisCount: 2,
// // // // // // // // // //                 childAspectRatio: 0.75,
// // // // // // // // // //                 crossAxisSpacing: 8,
// // // // // // // // // //                 mainAxisSpacing: 8,
// // // // // // // // // //               ),
// // // // // // // // // //               itemBuilder: (context, index) {
// // // // // // // // // //                 var product = products[index];
// // // // // // // // // //                 return GestureDetector(
// // // // // // // // // //                   onTap: () {
// // // // // // // // // //                     _showProductDetail(context, product);
// // // // // // // // // //                   },
// // // // // // // // // //                   child: Card(
// // // // // // // // // //                     shape: RoundedRectangleBorder(
// // // // // // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // // // // // //                     elevation: 4,
// // // // // // // // // //                     child: Column(
// // // // // // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // // // //                       children: [
// // // // // // // // // //                         Expanded(
// // // // // // // // // //                           child: ClipRRect(
// // // // // // // // // //                             borderRadius: const BorderRadius.vertical(
// // // // // // // // // //                                 top: Radius.circular(12)),
// // // // // // // // // //                             child: CachedNetworkImage(
// // // // // // // // // //                               imageUrl: product['image']!,
// // // // // // // // // //                               width: double.infinity,
// // // // // // // // // //                               fit: BoxFit.cover,
// // // // // // // // // //                             ),
// // // // // // // // // //                           ),
// // // // // // // // // //                         ),
// // // // // // // // // //                         Padding(
// // // // // // // // // //                           padding: const EdgeInsets.all(8.0),
// // // // // // // // // //                           child: Text(product['title']!,
// // // // // // // // // //                               style:
// // // // // // // // // //                                   const TextStyle(fontWeight: FontWeight.bold)),
// // // // // // // // // //                         ),
// // // // // // // // // //                         Padding(
// // // // // // // // // //                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
// // // // // // // // // //                           child: Row(
// // // // // // // // // //                             children: [
// // // // // // // // // //                               Text(product['price']!,
// // // // // // // // // //                                   style: const TextStyle(
// // // // // // // // // //                                       color: Colors.green,
// // // // // // // // // //                                       fontWeight: FontWeight.bold)),
// // // // // // // // // //                               const SizedBox(width: 5),
// // // // // // // // // //                               Text(product['mrp']!,
// // // // // // // // // //                                   style: const TextStyle(
// // // // // // // // // //                                       decoration: TextDecoration.lineThrough,
// // // // // // // // // //                                       color: Colors.grey)),
// // // // // // // // // //                             ],
// // // // // // // // // //                           ),
// // // // // // // // // //                         ),
// // // // // // // // // //                         Padding(
// // // // // // // // // //                           padding: const EdgeInsets.all(8.0),
// // // // // // // // // //                           child: ElevatedButton(
// // // // // // // // // //                             onPressed: () {},
// // // // // // // // // //                             style: ElevatedButton.styleFrom(
// // // // // // // // // //                                 backgroundColor: Colors.green,
// // // // // // // // // //                                 foregroundColor: Colors.white,
// // // // // // // // // //                                 shape: RoundedRectangleBorder(
// // // // // // // // // //                                   borderRadius: BorderRadius.circular(8),
// // // // // // // // // //                                 )),
// // // // // // // // // //                             child: const Text("ADD"),
// // // // // // // // // //                           ),
// // // // // // // // // //                         )
// // // // // // // // // //                       ],
// // // // // // // // // //                     ),
// // // // // // // // // //                   ),
// // // // // // // // // //                 );
// // // // // // // // // //               },
// // // // // // // // // //             ),
// // // // // // // // // //           ),
// // // // // // // // // //         ],
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }

// // // // // // // // // //   // Show Product Detail Modal
// // // // // // // // // //   void _showProductDetail(BuildContext context, Map<String, String> product) {
// // // // // // // // // //     showModalBottomSheet(
// // // // // // // // // //       context: context,
// // // // // // // // // //       backgroundColor: Colors.white,
// // // // // // // // // //       shape: const RoundedRectangleBorder(
// // // // // // // // // //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
// // // // // // // // // //       builder: (context) {
// // // // // // // // // //         return Padding(
// // // // // // // // // //           padding: const EdgeInsets.all(16),
// // // // // // // // // //           child: Column(
// // // // // // // // // //             mainAxisSize: MainAxisSize.min,
// // // // // // // // // //             children: [
// // // // // // // // // //               ClipRRect(
// // // // // // // // // //                 borderRadius: BorderRadius.circular(12),
// // // // // // // // // //                 child: CachedNetworkImage(
// // // // // // // // // //                   imageUrl: product['image']!,
// // // // // // // // // //                   height: 200,
// // // // // // // // // //                   width: double.infinity,
// // // // // // // // // //                   fit: BoxFit.cover,
// // // // // // // // // //                 ),
// // // // // // // // // //               ),
// // // // // // // // // //               const SizedBox(height: 10),
// // // // // // // // // //               Text(product['title']!,
// // // // // // // // // //                   style: const TextStyle(
// // // // // // // // // //                       fontSize: 20, fontWeight: FontWeight.bold)),
// // // // // // // // // //               const SizedBox(height: 5),
// // // // // // // // // //               Row(
// // // // // // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // // //                 children: [
// // // // // // // // // //                   Text(product['price']!,
// // // // // // // // // //                       style: const TextStyle(
// // // // // // // // // //                           fontSize: 18,
// // // // // // // // // //                           fontWeight: FontWeight.bold,
// // // // // // // // // //                           color: Colors.green)),
// // // // // // // // // //                   const SizedBox(width: 5),
// // // // // // // // // //                   Text(product['mrp']!,
// // // // // // // // // //                       style: const TextStyle(
// // // // // // // // // //                           fontSize: 16,
// // // // // // // // // //                           decoration: TextDecoration.lineThrough,
// // // // // // // // // //                           color: Colors.grey)),
// // // // // // // // // //                 ],
// // // // // // // // // //               ),
// // // // // // // // // //               const SizedBox(height: 15),
// // // // // // // // // //               ElevatedButton(
// // // // // // // // // //                 onPressed: () {},
// // // // // // // // // //                 style: ElevatedButton.styleFrom(
// // // // // // // // // //                     backgroundColor: Colors.green,
// // // // // // // // // //                     foregroundColor: Colors.white),
// // // // // // // // // //                 child: const Text("ADD"),
// // // // // // // // // //               ),
// // // // // // // // // //               const SizedBox(height: 20),
// // // // // // // // // //             ],
// // // // // // // // // //           ),
// // // // // // // // // //         );
// // // // // // // // // //       },
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }

// // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // // // // // class ProductScreen extends StatefulWidget {
// // // // // // // // //   const ProductScreen({super.key});

// // // // // // // // //   @override
// // // // // // // // //   _ProductScreenState createState() => _ProductScreenState();
// // // // // // // // // }

// // // // // // // // // class _ProductScreenState extends State<ProductScreen> {
// // // // // // // // //   int selectedCategoryIndex = 0;

// // // // // // // // //   // Dummy Categories
// // // // // // // // //   final List<Map<String, String>> categories = [
// // // // // // // // //     {'title': 'All', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // //     {'title': 'Banana', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // //     {'title': 'Apple', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // //     {'title': 'Oranges', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // //     {'title': 'Grapes', 'image': 'https://via.placeholder.com/50'},
// // // // // // // // //   ];

// // // // // // // // //   // Dummy Products
// // // // // // // // //   final List<Map<String, String>> products = [
// // // // // // // // //     {
// // // // // // // // //       'title': 'Banana (Robusta)',
// // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // //       'price': '₹35',
// // // // // // // // //       'mrp': '₹48'
// // // // // // // // //     },
// // // // // // // // //     {
// // // // // // // // //       'title': 'Nendran Banana',
// // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // //       'price': '₹60',
// // // // // // // // //       'mrp': '₹75'
// // // // // // // // //     },
// // // // // // // // //     {
// // // // // // // // //       'title': 'Green Apple',
// // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // //       'price': '₹120',
// // // // // // // // //       'mrp': '₹150'
// // // // // // // // //     },
// // // // // // // // //     {
// // // // // // // // //       'title': 'Red Grapes',
// // // // // // // // //       'image': 'https://via.placeholder.com/150',
// // // // // // // // //       'price': '₹80',
// // // // // // // // //       'mrp': '₹100'
// // // // // // // // //     },
// // // // // // // // //   ];

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       appBar: AppBar(title: const Text("Vegetables & Fruits")),
// // // // // // // // //       body: Row(
// // // // // // // // //         children: [
// // // // // // // // //           // 📌 Vertical Category List (Left Side)
// // // // // // // // //           SizedBox(
// // // // // // // // //             width: 100, // Adjust width based on UI needs
// // // // // // // // //             child: ListView.builder(
// // // // // // // // //               itemCount: categories.length,
// // // // // // // // //               itemBuilder: (context, index) {
// // // // // // // // //                 var category = categories[index];
// // // // // // // // //                 bool isSelected = selectedCategoryIndex == index;

// // // // // // // // //                 return GestureDetector(
// // // // // // // // //                   onTap: () {
// // // // // // // // //                     setState(() {
// // // // // // // // //                       selectedCategoryIndex = index;
// // // // // // // // //                     });
// // // // // // // // //                   },
// // // // // // // // //                   child: Padding(
// // // // // // // // //                     padding: const EdgeInsets.symmetric(vertical: 10),
// // // // // // // // //                     child: Column(
// // // // // // // // //                       children: [
// // // // // // // // //                         Container(
// // // // // // // // //                           padding: const EdgeInsets.all(8),
// // // // // // // // //                           decoration: BoxDecoration(
// // // // // // // // //                             color: isSelected ? Colors.green : Colors.grey[300],
// // // // // // // // //                             borderRadius: BorderRadius.circular(50),
// // // // // // // // //                           ),
// // // // // // // // //                           child: ClipRRect(
// // // // // // // // //                             borderRadius: BorderRadius.circular(25),
// // // // // // // // //                             child: CachedNetworkImage(
// // // // // // // // //                               imageUrl: category['image']!,
// // // // // // // // //                               width: 50,
// // // // // // // // //                               height: 50,
// // // // // // // // //                               fit: BoxFit.cover,
// // // // // // // // //                             ),
// // // // // // // // //                           ),
// // // // // // // // //                         ),
// // // // // // // // //                         const SizedBox(height: 5),
// // // // // // // // //                         Text(
// // // // // // // // //                           category['title']!,
// // // // // // // // //                           textAlign: TextAlign.center,
// // // // // // // // //                           style: TextStyle(
// // // // // // // // //                             fontSize: 12,
// // // // // // // // //                             fontWeight: isSelected
// // // // // // // // //                                 ? FontWeight.bold
// // // // // // // // //                                 : FontWeight.normal,
// // // // // // // // //                           ),
// // // // // // // // //                         ),
// // // // // // // // //                       ],
// // // // // // // // //                     ),
// // // // // // // // //                   ),
// // // // // // // // //                 );
// // // // // // // // //               },
// // // // // // // // //             ),
// // // // // // // // //           ),

// // // // // // // // //           // 📌 Product Grid (Right Side)
// // // // // // // // //           Expanded(
// // // // // // // // //             child: GridView.builder(
// // // // // // // // //               padding: const EdgeInsets.all(8),
// // // // // // // // //               itemCount: products.length,
// // // // // // // // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // // // //                 crossAxisCount: 2,
// // // // // // // // //                 childAspectRatio: 0.75,
// // // // // // // // //                 crossAxisSpacing: 8,
// // // // // // // // //                 mainAxisSpacing: 8,
// // // // // // // // //               ),
// // // // // // // // //               itemBuilder: (context, index) {
// // // // // // // // //                 var product = products[index];
// // // // // // // // //                 return GestureDetector(
// // // // // // // // //                   onTap: () {
// // // // // // // // //                     _showProductDetail(context, product);
// // // // // // // // //                   },
// // // // // // // // //                   child: Card(
// // // // // // // // //                     shape: RoundedRectangleBorder(
// // // // // // // // //                         borderRadius: BorderRadius.circular(12)),
// // // // // // // // //                     elevation: 4,
// // // // // // // // //                     child: Column(
// // // // // // // // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // // //                       children: [
// // // // // // // // //                         Expanded(
// // // // // // // // //                           child: ClipRRect(
// // // // // // // // //                             borderRadius: const BorderRadius.vertical(
// // // // // // // // //                                 top: Radius.circular(12)),
// // // // // // // // //                             child: CachedNetworkImage(
// // // // // // // // //                               imageUrl: product['image']!,
// // // // // // // // //                               width: double.infinity,
// // // // // // // // //                               fit: BoxFit.cover,
// // // // // // // // //                             ),
// // // // // // // // //                           ),
// // // // // // // // //                         ),
// // // // // // // // //                         Padding(
// // // // // // // // //                           padding: const EdgeInsets.all(8.0),
// // // // // // // // //                           child: Text(product['title']!,
// // // // // // // // //                               style:
// // // // // // // // //                                   const TextStyle(fontWeight: FontWeight.bold)),
// // // // // // // // //                         ),
// // // // // // // // //                         Padding(
// // // // // // // // //                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
// // // // // // // // //                           child: Row(
// // // // // // // // //                             children: [
// // // // // // // // //                               Text(product['price']!,
// // // // // // // // //                                   style: const TextStyle(
// // // // // // // // //                                       color: Colors.green,
// // // // // // // // //                                       fontWeight: FontWeight.bold)),
// // // // // // // // //                               const SizedBox(width: 5),
// // // // // // // // //                               Text(product['mrp']!,
// // // // // // // // //                                   style: const TextStyle(
// // // // // // // // //                                       decoration: TextDecoration.lineThrough,
// // // // // // // // //                                       color: Colors.grey)),
// // // // // // // // //                             ],
// // // // // // // // //                           ),
// // // // // // // // //                         ),
// // // // // // // // //                         Padding(
// // // // // // // // //                           padding: const EdgeInsets.all(8.0),
// // // // // // // // //                           child: ElevatedButton(
// // // // // // // // //                             onPressed: () {},
// // // // // // // // //                             style: ElevatedButton.styleFrom(
// // // // // // // // //                                 backgroundColor: Colors.green,
// // // // // // // // //                                 foregroundColor: Colors.white,
// // // // // // // // //                                 shape: RoundedRectangleBorder(
// // // // // // // // //                                   borderRadius: BorderRadius.circular(8),
// // // // // // // // //                                 )),
// // // // // // // // //                             child: const Text("ADD"),
// // // // // // // // //                           ),
// // // // // // // // //                         )
// // // // // // // // //                       ],
// // // // // // // // //                     ),
// // // // // // // // //                   ),
// // // // // // // // //                 );
// // // // // // // // //               },
// // // // // // // // //             ),
// // // // // // // // //           ),
// // // // // // // // //         ],
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }

// // // // // // // // //   // 📌 Show Product Detail Modal
// // // // // // // // //   void _showProductDetail(BuildContext context, Map<String, String> product) {
// // // // // // // // //     showModalBottomSheet(
// // // // // // // // //       context: context,
// // // // // // // // //       backgroundColor: Colors.white,
// // // // // // // // //       shape: const RoundedRectangleBorder(
// // // // // // // // //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
// // // // // // // // //       builder: (context) {
// // // // // // // // //         return Padding(
// // // // // // // // //           padding: const EdgeInsets.all(16),
// // // // // // // // //           child: Column(
// // // // // // // // //             mainAxisSize: MainAxisSize.min,
// // // // // // // // //             children: [
// // // // // // // // //               ClipRRect(
// // // // // // // // //                 borderRadius: BorderRadius.circular(12),
// // // // // // // // //                 child: CachedNetworkImage(
// // // // // // // // //                   imageUrl: product['image']!,
// // // // // // // // //                   height: 200,
// // // // // // // // //                   width: double.infinity,
// // // // // // // // //                   fit: BoxFit.cover,
// // // // // // // // //                 ),
// // // // // // // // //               ),
// // // // // // // // //               const SizedBox(height: 10),
// // // // // // // // //               Text(product['title']!,
// // // // // // // // //                   style: const TextStyle(
// // // // // // // // //                       fontSize: 20, fontWeight: FontWeight.bold)),
// // // // // // // // //               const SizedBox(height: 5),
// // // // // // // // //               Row(
// // // // // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // // //                 children: [
// // // // // // // // //                   Text(product['price']!,
// // // // // // // // //                       style: const TextStyle(
// // // // // // // // //                           fontSize: 18,
// // // // // // // // //                           fontWeight: FontWeight.bold,
// // // // // // // // //                           color: Colors.green)),
// // // // // // // // //                   const SizedBox(width: 5),
// // // // // // // // //                   Text(product['mrp']!,
// // // // // // // // //                       style: const TextStyle(
// // // // // // // // //                           fontSize: 16,
// // // // // // // // //                           decoration: TextDecoration.lineThrough,
// // // // // // // // //                           color: Colors.grey)),
// // // // // // // // //                 ],
// // // // // // // // //               ),
// // // // // // // // //               const SizedBox(height: 15),
// // // // // // // // //               ElevatedButton(
// // // // // // // // //                 onPressed: () {},
// // // // // // // // //                 style: ElevatedButton.styleFrom(
// // // // // // // // //                     backgroundColor: Colors.green,
// // // // // // // // //                     foregroundColor: Colors.white),
// // // // // // // // //                 child: const Text("ADD"),
// // // // // // // // //               ),
// // // // // // // // //               const SizedBox(height: 20),
// // // // // // // // //             ],
// // // // // // // // //           ),
// // // // // // // // //         );
// // // // // // // // //       },
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // import 'package:category_product_listing/providers/product_notifer.dart';
// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // // // // // // import '../models/category_list_model.dart';
// // // // // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // // // // class ProductScreen extends ConsumerStatefulWidget {
// // // // // // // //   const ProductScreen({super.key});

// // // // // // // //   @override
// // // // // // // //   _ProductScreenState createState() => _ProductScreenState();
// // // // // // // // }

// // // // // // // // class _ProductScreenState extends ConsumerState<ProductScreen> {
// // // // // // // //   late ScrollController _scrollController;
// // // // // // // //   String? selectedCategoryId;

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     _scrollController = ScrollController()..addListener(_scrollListener);
// // // // // // // //     ref.read(productProvider.notifier).fetchProducts(); // Initial API call
// // // // // // // //   }

// // // // // // // //   // ✅ Pagination - Load more when reaching bottom
// // // // // // // //   void _scrollListener() {
// // // // // // // //     if (_scrollController.position.pixels >=
// // // // // // // //         _scrollController.position.maxScrollExtent) {
// // // // // // // //       ref
// // // // // // // //           .read(productProvider.notifier)
// // // // // // // //           .fetchProducts(categoryId: selectedCategoryId);
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     final productState = ref.watch(productProvider);

// // // // // // // //     return Scaffold(
// // // // // // // //       appBar: AppBar(title: const Text("Vegetables & Fruits")),
// // // // // // // //       body: Row(
// // // // // // // //         children: [
// // // // // // // //           // ✅ Vertical Category List (Left Side)
// // // // // // // //           SizedBox(
// // // // // // // //             width: 100,
// // // // // // // //             child: productState.isLoading && productState.categories.isEmpty
// // // // // // // //                 ? const Center(child: CircularProgressIndicator())
// // // // // // // //                 : ListView.builder(
// // // // // // // //                     itemCount: productState.categories.length,
// // // // // // // //                     itemBuilder: (context, index) {
// // // // // // // //                       final category = productState.categories[index];
// // // // // // // //                       final isSelected = selectedCategoryId == category.id;

// // // // // // // //                       return GestureDetector(
// // // // // // // //                         onTap: () {
// // // // // // // //                           setState(() {
// // // // // // // //                             selectedCategoryId = category.id;
// // // // // // // //                           });
// // // // // // // //                           ref
// // // // // // // //                               .read(productProvider.notifier)
// // // // // // // //                               .fetchProducts(categoryId: category.id);
// // // // // // // //                         },
// // // // // // // //                         child: Padding(
// // // // // // // //                           padding: const EdgeInsets.symmetric(vertical: 10),
// // // // // // // //                           child: Column(
// // // // // // // //                             children: [
// // // // // // // //                               Container(
// // // // // // // //                                 padding: const EdgeInsets.all(8),
// // // // // // // //                                 decoration: BoxDecoration(
// // // // // // // //                                   color: isSelected
// // // // // // // //                                       ? Colors.green
// // // // // // // //                                       : Colors.grey[300],
// // // // // // // //                                   borderRadius: BorderRadius.circular(50),
// // // // // // // //                                 ),
// // // // // // // //                                 child: ClipRRect(
// // // // // // // //                                   borderRadius: BorderRadius.circular(25),
// // // // // // // //                                   child: CachedNetworkImage(
// // // // // // // //                                     imageUrl: category.imageUrl,
// // // // // // // //                                     width: 50,
// // // // // // // //                                     height: 50,
// // // // // // // //                                     fit: BoxFit.cover,
// // // // // // // //                                   ),
// // // // // // // //                                 ),
// // // // // // // //                               ),
// // // // // // // //                               const SizedBox(height: 5),
// // // // // // // //                               Text(
// // // // // // // //                                 category.title,
// // // // // // // //                                 textAlign: TextAlign.center,
// // // // // // // //                                 style: TextStyle(
// // // // // // // //                                   fontSize: 12,
// // // // // // // //                                   fontWeight: isSelected
// // // // // // // //                                       ? FontWeight.bold
// // // // // // // //                                       : FontWeight.normal,
// // // // // // // //                                 ),
// // // // // // // //                               ),
// // // // // // // //                             ],
// // // // // // // //                           ),
// // // // // // // //                         ),
// // // // // // // //                       );
// // // // // // // //                     },
// // // // // // // //                   ),
// // // // // // // //           ),

// // // // // // // //           // ✅ Product Grid (Right Side)
// // // // // // // //           Expanded(
// // // // // // // //             child: productState.isLoading && productState.products.isEmpty
// // // // // // // //                 ? const Center(child: CircularProgressIndicator())
// // // // // // // //                 : productState.error != null
// // // // // // // //                     ? Center(child: Text("Error: ${productState.error}"))
// // // // // // // //                     : GridView.builder(
// // // // // // // //                         controller: _scrollController,
// // // // // // // //                         padding: const EdgeInsets.all(8),
// // // // // // // //                         itemCount: productState.products.length +
// // // // // // // //                             (productState.isLoading ? 1 : 0),
// // // // // // // //                         gridDelegate:
// // // // // // // //                             const SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // // //                           crossAxisCount: 2,
// // // // // // // //                           childAspectRatio: 0.75,
// // // // // // // //                           crossAxisSpacing: 8,
// // // // // // // //                           mainAxisSpacing: 8,
// // // // // // // //                         ),
// // // // // // // //                         itemBuilder: (context, index) {
// // // // // // // //                           if (index == productState.products.length) {
// // // // // // // //                             return const Center(
// // // // // // // //                                 child: CircularProgressIndicator());
// // // // // // // //                           }
// // // // // // // //                           final product = productState.products[index];
// // // // // // // //                           return GestureDetector(
// // // // // // // //                             onTap: () {
// // // // // // // //                               _showProductDetail(context, product);
// // // // // // // //                             },
// // // // // // // //                             child: Card(
// // // // // // // //                               shape: RoundedRectangleBorder(
// // // // // // // //                                   borderRadius: BorderRadius.circular(12)),
// // // // // // // //                               elevation: 4,
// // // // // // // //                               child: Column(
// // // // // // // //                                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // //                                 children: [
// // // // // // // //                                   Expanded(
// // // // // // // //                                     child: ClipRRect(
// // // // // // // //                                       borderRadius: const BorderRadius.vertical(
// // // // // // // //                                           top: Radius.circular(12)),
// // // // // // // //                                       child: CachedNetworkImage(
// // // // // // // //                                         imageUrl: product.imageUrl,
// // // // // // // //                                         width: double.infinity,
// // // // // // // //                                         fit: BoxFit.cover,
// // // // // // // //                                       ),
// // // // // // // //                                     ),
// // // // // // // //                                   ),
// // // // // // // //                                   Padding(
// // // // // // // //                                     padding: const EdgeInsets.all(8.0),
// // // // // // // //                                     child: Text(product.title,
// // // // // // // //                                         style: const TextStyle(
// // // // // // // //                                             fontWeight: FontWeight.bold)),
// // // // // // // //                                   ),
// // // // // // // //                                   Padding(
// // // // // // // //                                     padding: const EdgeInsets.symmetric(
// // // // // // // //                                         horizontal: 8.0),
// // // // // // // //                                     child: Row(
// // // // // // // //                                       children: [
// // // // // // // //                                         Text("₹${product.price}",
// // // // // // // //                                             style: const TextStyle(
// // // // // // // //                                                 color: Colors.green,
// // // // // // // //                                                 fontWeight: FontWeight.bold)),
// // // // // // // //                                         const SizedBox(width: 5),
// // // // // // // //                                         Text("₹${product.discountPrice}",
// // // // // // // //                                             style: const TextStyle(
// // // // // // // //                                                 decoration:
// // // // // // // //                                                     TextDecoration.lineThrough,
// // // // // // // //                                                 color: Colors.grey)),
// // // // // // // //                                       ],
// // // // // // // //                                     ),
// // // // // // // //                                   ),
// // // // // // // //                                   Padding(
// // // // // // // //                                     padding: const EdgeInsets.all(8.0),
// // // // // // // //                                     child: ElevatedButton(
// // // // // // // //                                       onPressed: () {},
// // // // // // // //                                       style: ElevatedButton.styleFrom(
// // // // // // // //                                           backgroundColor: Colors.green,
// // // // // // // //                                           foregroundColor: Colors.white,
// // // // // // // //                                           shape: RoundedRectangleBorder(
// // // // // // // //                                             borderRadius:
// // // // // // // //                                                 BorderRadius.circular(8),
// // // // // // // //                                           )),
// // // // // // // //                                       child: const Text("ADD"),
// // // // // // // //                                     ),
// // // // // // // //                                   )
// // // // // // // //                                 ],
// // // // // // // //                               ),
// // // // // // // //                             ),
// // // // // // // //                           );
// // // // // // // //                         },
// // // // // // // //                       ),
// // // // // // // //           ),
// // // // // // // //         ],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   // 📌 Show Product Detail Modal
// // // // // // // //   void _showProductDetail(BuildContext context, Product product) {
// // // // // // // //     showModalBottomSheet(
// // // // // // // //       context: context,
// // // // // // // //       backgroundColor: Colors.white,
// // // // // // // //       shape: const RoundedRectangleBorder(
// // // // // // // //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
// // // // // // // //       builder: (context) {
// // // // // // // //         return Padding(
// // // // // // // //           padding: const EdgeInsets.all(16),
// // // // // // // //           child: Column(
// // // // // // // //             mainAxisSize: MainAxisSize.min,
// // // // // // // //             children: [
// // // // // // // //               ClipRRect(
// // // // // // // //                 borderRadius: BorderRadius.circular(12),
// // // // // // // //                 child: CachedNetworkImage(
// // // // // // // //                   imageUrl: product.imageUrl,
// // // // // // // //                   height: 200,
// // // // // // // //                   width: double.infinity,
// // // // // // // //                   fit: BoxFit.cover,
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //               const SizedBox(height: 10),
// // // // // // // //               Text(product.title,
// // // // // // // //                   style: const TextStyle(
// // // // // // // //                       fontSize: 20, fontWeight: FontWeight.bold)),
// // // // // // // //               const SizedBox(height: 5),
// // // // // // // //               Row(
// // // // // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // //                 children: [
// // // // // // // //                   Text("₹${product.price}",
// // // // // // // //                       style: const TextStyle(
// // // // // // // //                           fontSize: 18,
// // // // // // // //                           fontWeight: FontWeight.bold,
// // // // // // // //                           color: Colors.green)),
// // // // // // // //                   const SizedBox(width: 5),
// // // // // // // //                   Text("₹${product.discountPrice}",
// // // // // // // //                       style: const TextStyle(
// // // // // // // //                           fontSize: 16,
// // // // // // // //                           decoration: TextDecoration.lineThrough,
// // // // // // // //                           color: Colors.grey)),
// // // // // // // //                 ],
// // // // // // // //               ),
// // // // // // // //               const SizedBox(height: 15),
// // // // // // // //               ElevatedButton(
// // // // // // // //                 onPressed: () {},
// // // // // // // //                 style: ElevatedButton.styleFrom(
// // // // // // // //                     backgroundColor: Colors.green,
// // // // // // // //                     foregroundColor: Colors.white),
// // // // // // // //                 child: const Text("ADD"),
// // // // // // // //               ),
// // // // // // // //               const SizedBox(height: 20),
// // // // // // // //             ],
// // // // // // // //           ),
// // // // // // // //         );
// // // // // // // //       },
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:category_product_listing/providers/product_notifer.dart';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // // // // import '../models/category_list_model.dart';
// // // // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // // // class ProductScreen extends ConsumerStatefulWidget {
// // // // // // //   const ProductScreen({super.key});

// // // // // // //   @override
// // // // // // //   _ProductScreenState createState() => _ProductScreenState();
// // // // // // // }

// // // // // // // class _ProductScreenState extends ConsumerState<ProductScreen> {
// // // // // // //   late ScrollController _scrollController;
// // // // // // //   String? selectedCategoryId;

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     _scrollController = ScrollController()..addListener(_scrollListener);
// // // // // // //     // ref.read(productProvider.notifier).fetchProducts(); // Initial API call
// // // // // // //   }

// // // // // // //   // ✅ Pagination - Load more when reaching bottom
// // // // // // //   void _scrollListener() {
// // // // // // //     if (_scrollController.position.pixels >=
// // // // // // //         _scrollController.position.maxScrollExtent) {
// // // // // // //       ref
// // // // // // //           .read(productProvider.notifier)
// // // // // // //           .fetchProducts(categoryId: selectedCategoryId);
// // // // // // //     }
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     final productState = ref.watch(productProvider);

// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(title: const Text("Vegetables & Fruits")),
// // // // // // //       body: Row(
// // // // // // //         children: [
// // // // // // //           // ✅ Vertical Category List (Left Side)
// // // // // // //           SizedBox(
// // // // // // //             width: 100,
// // // // // // //             child: productState.isLoading && productState.categories.isEmpty
// // // // // // //                 ? const Center(child: CircularProgressIndicator())
// // // // // // //                 : ListView.builder(
// // // // // // //                     itemCount: productState.categories.length,
// // // // // // //                     itemBuilder: (context, index) {
// // // // // // //                       final category = productState.categories[index];
// // // // // // //                       final isSelected = selectedCategoryId == category.id;

// // // // // // //                       return GestureDetector(
// // // // // // //                         onTap: () {
// // // // // // //                           setState(() {
// // // // // // //                             selectedCategoryId = category.id;
// // // // // // //                           });
// // // // // // //                           ref.read(productProvider.notifier).fetchProducts(
// // // // // // //                               categoryId: category.id, reset: true);
// // // // // // //                         },
// // // // // // //                         child: Padding(
// // // // // // //                           padding: const EdgeInsets.symmetric(vertical: 10),
// // // // // // //                           child: Column(
// // // // // // //                             children: [
// // // // // // //                               Container(
// // // // // // //                                 padding: const EdgeInsets.all(8),
// // // // // // //                                 decoration: BoxDecoration(
// // // // // // //                                   color: isSelected
// // // // // // //                                       ? Colors.green
// // // // // // //                                       : Colors.grey[300],
// // // // // // //                                   borderRadius: BorderRadius.circular(50),
// // // // // // //                                 ),
// // // // // // //                                 child: ClipRRect(
// // // // // // //                                   borderRadius: BorderRadius.circular(25),
// // // // // // //                                   child: CachedNetworkImage(
// // // // // // //                                     imageUrl: category.imageUrl,
// // // // // // //                                     width: 50,
// // // // // // //                                     height: 50,
// // // // // // //                                     fit: BoxFit.cover,
// // // // // // //                                   ),
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                               const SizedBox(height: 5),
// // // // // // //                               Text(
// // // // // // //                                 category.title,
// // // // // // //                                 textAlign: TextAlign.center,
// // // // // // //                                 style: TextStyle(
// // // // // // //                                   fontSize: 12,
// // // // // // //                                   fontWeight: isSelected
// // // // // // //                                       ? FontWeight.bold
// // // // // // //                                       : FontWeight.normal,
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                             ],
// // // // // // //                           ),
// // // // // // //                         ),
// // // // // // //                       );
// // // // // // //                     },
// // // // // // //                   ),
// // // // // // //           ),

// // // // // // //           // ✅ Product Grid (Right Side)
// // // // // // //           Expanded(
// // // // // // //             child: productState.isLoading && productState.products.isEmpty
// // // // // // //                 ? const Center(child: CircularProgressIndicator())
// // // // // // //                 : productState.error != null
// // // // // // //                     ? Center(child: Text("Error: ${productState.error}"))
// // // // // // //                     : GridView.builder(
// // // // // // //                         controller: _scrollController,
// // // // // // //                         padding: const EdgeInsets.all(8),
// // // // // // //                         itemCount: productState.products.length +
// // // // // // //                             (productState.isLoading ? 1 : 0),
// // // // // // //                         gridDelegate:
// // // // // // //                             const SliverGridDelegateWithFixedCrossAxisCount(
// // // // // // //                           crossAxisCount: 2,
// // // // // // //                           childAspectRatio: 0.75,
// // // // // // //                           crossAxisSpacing: 8,
// // // // // // //                           mainAxisSpacing: 8,
// // // // // // //                         ),
// // // // // // //                         itemBuilder: (context, index) {
// // // // // // //                           if (index == productState.products.length) {
// // // // // // //                             return const Center(
// // // // // // //                                 child: CircularProgressIndicator());
// // // // // // //                           }
// // // // // // //                           final product = productState.products[index];
// // // // // // //                           return Card(
// // // // // // //                             child: Column(
// // // // // // //                               children: [
// // // // // // //                                 CachedNetworkImage(
// // // // // // //                                     imageUrl: product.imageUrl,
// // // // // // //                                     height: 100,
// // // // // // //                                     fit: BoxFit.cover),
// // // // // // //                                 Text(product.title,
// // // // // // //                                     style: const TextStyle(
// // // // // // //                                         fontWeight: FontWeight.bold)),
// // // // // // //                                 Text("₹${product.price}",
// // // // // // //                                     style:
// // // // // // //                                         const TextStyle(color: Colors.green)),
// // // // // // //                                 ElevatedButton(
// // // // // // //                                     onPressed: () {}, child: const Text("ADD")),
// // // // // // // //                               ],
// // // // // // // //                             ),
// // // // // // // //                           );
// // // // // // // //                         },
// // // // // // // //                       ),
// // // // // // // //           ),
// // // // // // // //         ],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:category_product_listing/providers/product_notifer.dart';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // // // // // class ProductListView extends ConsumerWidget {
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // // // // //     final productState = ref.watch(productProvider);

// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(title: Text('Products & Categories')),
// // // // // // //       body: productState.isLoading
// // // // // // //           ? Center(child: CircularProgressIndicator())
// // // // // // //           : productState.errorMessage != null
// // // // // // //               ? Center(child: Text('Error: ${productState.errorMessage}'))
// // // // // // //               : Column(
// // // // // // //                   children: [
// // // // // // //                     Expanded(
// // // // // // //                       child: ListView.builder(
// // // // // // //                         itemCount: productState.products.length,
// // // // // // //                         itemBuilder: (context, index) {
// // // // // // //                           final product = productState.products[index];
// // // // // // //                           return ListTile(
// // // // // // //                             leading: Image.network(product.imageUrl,
// // // // // // //                                 width: 50, height: 50, fit: BoxFit.cover),
// // // // // // //                             title: Text(product.title),
// // // // // // //                             subtitle: Text('Price: \$${product.price}'),
// // // // // // //                           );
// // // // // // //                         },
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                     SizedBox(height: 10),
// // // // // // //                     Text('Categories',
// // // // // // //                         style: TextStyle(
// // // // // // //                             fontSize: 18, fontWeight: FontWeight.bold)),
// // // // // // //                     Wrap(
// // // // // // //                       spacing: 8,
// // // // // // //                       children: productState.categories.map((category) {
// // // // // // //                         return Chip(
// // // // // // //                           label: Text(category.title),
// // // // // // //                           avatar: category.imageUrl.isNotEmpty
// // // // // // //                               ? CircleAvatar(
// // // // // // //                                   backgroundImage:
// // // // // // //                                       NetworkImage(category.imageUrl))
// // // // // // //                               : null,
// // // // // // //                         );
// // // // // // //                       }).toList(),
// // // // // // //                     ),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //       floatingActionButton: FloatingActionButton(
// // // // // // //         onPressed: () =>
// // // // // // //             ref.read(productProvider.notifier).fetchProducts(page: 1),
// // // // // // //         child: Icon(Icons.refresh),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // import 'package:category_product_listing/models/category_list_model.dart';
// // // // // import 'package:category_product_listing/providers/product_notifer.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // // import 'package:cached_network_image/cached_network_image.dart';

// // // // // class ProductListView extends ConsumerWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // // //     final productState = ref.watch(productProvider);

// // // // //     return Scaffold(
// // // // //       appBar: AppBar(title: Text('Vegetables & Fruits')),
// // // // //       body: Row(
// // // // //         children: [
// // // // //           // 📌 Vertical Category List (Left Side)
// // // // //           SizedBox(
// // // // //             width: 100, // Adjust width based on UI needs
// // // // //             child: ListView.builder(
// // // // //               itemCount: productState.categories.length,
// // // // //               itemBuilder: (context, index) {
// // // // //                 final category = productState.categories[index];
// // // // //                 return GestureDetector(
// // // // //                   onTap: () => ref
// // // // //                       .read(productProvider.notifier)
// // // // //                       .fetchProducts(categoryId: category.id, page: 1),
// // // // //                   child: Padding(
// // // // //                     padding: const EdgeInsets.symmetric(vertical: 10),
// // // // //                     child: Column(
// // // // //                       children: [
// // // // //                         Container(
// // // // //                           padding: const EdgeInsets.all(8),
// // // // //                           decoration: BoxDecoration(
// // // // //                             color: Colors.green,
// // // // //                             borderRadius: BorderRadius.circular(50),
// // // // //                           ),
// // // // //                           child: ClipRRect(
// // // // //                             borderRadius: BorderRadius.circular(25),
// // // // //                             child: CachedNetworkImage(
// // // // //                               imageUrl: category.imageUrl,
// // // // //                               width: 50,
// // // // //                               height: 50,
// // // // //                               fit: BoxFit.cover,
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                         const SizedBox(height: 5),
// // // // //                         Text(category.title,
// // // // //                             textAlign: TextAlign.center,
// // // // //                             style: TextStyle(fontSize: 12)),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 );
// // // // //               },
// // // // //             ),
// // // // //           ),
// // // // //           // 📌 Product Grid (Right Side)
// // // // //           Expanded(
// // // // //             child: productState.isLoading
// // // // //                 ? Center(child: CircularProgressIndicator())
// // // // //                 : productState.errorMessage != null
// // // // //                     ? Center(child: Text('Error: ${productState.errorMessage}'))
// // // // //                     : GridView.builder(
// // // // //                         padding: const EdgeInsets.all(8),
// // // // //                         itemCount: productState.products.length,
// // // // //                         gridDelegate:
// // // // //                             const SliverGridDelegateWithFixedCrossAxisCount(
// // // // //                           crossAxisCount: 2,
// // // // //                           childAspectRatio: 0.75,
// // // // //                           crossAxisSpacing: 8,
// // // // //                           mainAxisSpacing: 8,
// // // // //                         ),
// // // // //                         itemBuilder: (context, index) {
// // // // //                           final product = productState.products[index];
// // // // //                           return GestureDetector(
// // // // //                             onTap: () => _showProductDetail(context, product),
// // // // //                             child: Card(
// // // // //                               shape: RoundedRectangleBorder(
// // // // //                                   borderRadius: BorderRadius.circular(12)),
// // // // //                               elevation: 4,
// // // // //                               child: Column(
// // // // //                                 crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                                 children: [
// // // // //                                   Expanded(
// // // // //                                     child: ClipRRect(
// // // // //                                       borderRadius: const BorderRadius.vertical(
// // // // //                                           top: Radius.circular(12)),
// // // // //                                       child: CachedNetworkImage(
// // // // //                                         imageUrl: product.imageUrl,
// // // // //                                         width: double.infinity,
// // // // //                                         fit: BoxFit.cover,
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                   Padding(
// // // // //                                     padding: const EdgeInsets.all(8.0),
// // // // //                                     child: Text(product.title,
// // // // //                                         style: const TextStyle(
// // // // //                                             fontWeight: FontWeight.bold)),
// // // // //                                   ),
// // // // //                                   Padding(
// // // // //                                     padding: const EdgeInsets.symmetric(
// // // // //                                         horizontal: 8.0),
// // // // //                                     child: Row(
// // // // //                                       children: [
// // // // //                                         Text('₹${product.price}',
// // // // //                                             style: const TextStyle(
// // // // //                                                 color: Colors.green,
// // // // //                                                 fontWeight: FontWeight.bold)),
// // // // //                                         const SizedBox(width: 5),
// // // // //                                         Text('₹${product.discountPrice}',
// // // // //                                             style: const TextStyle(
// // // // //                                                 decoration:
// // // // //                                                     TextDecoration.lineThrough,
// // // // //                                                 color: Colors.grey)),
// // // // //                                       ],
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                 ],
// // // // //                               ),
// // // // //                             ),
// // // // //                           );
// // // // //                         },
// // // // //                       ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   // 📌 Show Product Detail Modal
// // // // //   void _showProductDetail(BuildContext context, Product product) {
// // // // //     showModalBottomSheet(
// // // // //       context: context,
// // // // //       backgroundColor: Colors.white,
// // // // //       shape: const RoundedRectangleBorder(
// // // // //           borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
// // // // //       builder: (context) {
// // // // //         return Padding(
// // // // //           padding: const EdgeInsets.all(16),
// // // // //           child: Column(
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             children: [
// // // // //               ClipRRect(
// // // // //                 borderRadius: BorderRadius.circular(12),
// // // // //                 child: CachedNetworkImage(
// // // // //                   imageUrl: product.imageUrl,
// // // // //                   height: 200,
// // // // //                   width: double.infinity,
// // // // //                   fit: BoxFit.cover,
// // // // //                 ),
// // // // //               ),
// // // // //               const SizedBox(height: 10),
// // // // //               Text(product.title,
// // // // //                   style: const TextStyle(
// // // // //                       fontSize: 20, fontWeight: FontWeight.bold)),
// // // // //               const SizedBox(height: 5),
// // // // //               Row(
// // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                 children: [
// // // // //                   Text('₹${product.price}',
// // // // //                       style: const TextStyle(
// // // // //                           fontSize: 18,
// // // // //                           fontWeight: FontWeight.bold,
// // // // //                           color: Colors.green)),
// // // // //                   const SizedBox(width: 5),
// // // // //                   Text('₹${product.discountPrice}',
// // // // //                       style: const TextStyle(
// // // // //                           fontSize: 16,
// // // // //                           decoration: TextDecoration.lineThrough,
// // // // //                           color: Colors.grey)),
// // // // //                 ],
// // // // //               ),
// // // // //               const SizedBox(height: 15),
// // // // //               ElevatedButton(
// // // // //                 onPressed: () {},
// // // // //                 style: ElevatedButton.styleFrom(
// // // // //                     backgroundColor: Colors.green,
// // // // //                     foregroundColor: Colors.white),
// // // // //                 child: const Text("ADD"),
// // // // //               ),
// // // // //               const SizedBox(height: 20),
// // // // //             ],
// // // // //           ),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // import 'package:cached_network_image/cached_network_image.dart';
// // // // import 'package:dio/dio.dart';
// // // // import '../services/category_list_services.dart';
// // // // import '../models/category_list_model.dart';

// // // // // ✅ API Service Provider
// // // // final apiServiceProvider = Provider<ApiService>((ref) {
// // // //   return ApiService(Dio());
// // // // });

// // // // // ✅ Product State
// // // // class ProductState {
// // // //   final List<Product> products;
// // // //   final List<Category> categories;
// // // //   final bool isLoading;
// // // //   final String? errorMessage;

// // // //   ProductState({
// // // //     required this.products,
// // // //     required this.categories,
// // // //     required this.isLoading,
// // // //     this.errorMessage,
// // // //   });

// // // //   ProductState copyWith({
// // // //     List<Product>? products,
// // // //     List<Category>? categories,
// // // //     bool? isLoading,
// // // //     String? errorMessage,
// // // //   }) {
// // // //     return ProductState(
// // // //       products: products ?? this.products,
// // // //       categories: categories ?? this.categories,
// // // //       isLoading: isLoading ?? this.isLoading,
// // // //       errorMessage: errorMessage ?? this.errorMessage,
// // // //     );
// // // //   }
// // // // }

// // // // // ✅ Product Notifier
// // // // class ProductNotifier extends StateNotifier<ProductState> {
// // // //   final ApiService _apiService;

// // // //   ProductNotifier(this._apiService)
// // // //       : super(ProductState(products: [], categories: [], isLoading: true)) {
// // // //     fetchProducts(page: 1);
// // // //   }

// // // //   Future<void> fetchProducts({String? categoryId, required int page}) async {
// // // //     state = state.copyWith(isLoading: true, errorMessage: null);
// // // //     try {
// // // //       final response =
// // // //           await _apiService.fetchProducts(categoryId: categoryId, page: page);
// // // //       state = state.copyWith(
// // // //         products: response.products,
// // // //         categories: response.categories,
// // // //         isLoading: false,
// // // //       );
// // // //     } catch (e) {
// // // //       state = state.copyWith(isLoading: false, errorMessage: e.toString());
// // // //     }
// // // //   }
// // // // }

// // // // // ✅ Product Provider
// // // // final productProvider =
// // // //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// // // //   final apiService = ref.read(apiServiceProvider);
// // // //   return ProductNotifier(apiService);
// // // // });

// // // // class ProductListView extends ConsumerWidget {
// // // //   @override
// // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // //     final productState = ref.watch(productProvider);

// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text('Vegetables & Fruits')),
// // // //       body: Row(
// // // //         children: [
// // // //           // 📌 Vertical Category List (Left Side)
// // // //           SizedBox(
// // // //             width: 100,
// // // //             child: ListView.builder(
// // // //               itemCount: productState.categories.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final category = productState.categories[index];
// // // //                 return GestureDetector(
// // // //                   onTap: () {
// // // //                     print("Selected Category ID: ${category.id}");
// // // //                     ref
// // // //                         .read(productProvider.notifier)
// // // //                         .fetchProducts(categoryId: category.id, page: 1);
// // // //                   },
// // // //                   child: Padding(
// // // //                     padding: const EdgeInsets.symmetric(vertical: 10),
// // // //                     child: Column(
// // // //                       children: [
// // // //                         Container(
// // // //                           padding: const EdgeInsets.all(8),
// // // //                           decoration: BoxDecoration(
// // // //                             color: Colors.green,
// // // //                             borderRadius: BorderRadius.circular(50),
// // // //                           ),
// // // //                           child: ClipRRect(
// // // //                             borderRadius: BorderRadius.circular(25),
// // // //                             child: CachedNetworkImage(
// // // //                               imageUrl: category.imageUrl,
// // // //                               width: 50,
// // // //                               height: 50,
// // // //                               fit: BoxFit.cover,
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                         const SizedBox(height: 5),
// // // //                         Text(category.title,
// // // //                             textAlign: TextAlign.center,
// // // //                             style: TextStyle(fontSize: 12)),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                 );

// // // //                 // GestureDetector(
// // // //                 //   onTap: () => ref
// // // //                 //       .read(productProvider.notifier)
// // // //                 //       .fetchProducts(categoryId: category.id, page: 1),
// // // //                 //   child: Padding(
// // // //                 //     padding: const EdgeInsets.symmetric(vertical: 10),
// // // //                 //     child: Column(
// // // //                 //       children: [
// // // //                 //         Container(
// // // //                 //           padding: const EdgeInsets.all(8),
// // // //                 //           decoration: BoxDecoration(
// // // //                 //             color: Colors.green,
// // // //                 //             borderRadius: BorderRadius.circular(50),
// // // //                 //           ),
// // // //                 //           child: ClipRRect(
// // // //                 //             borderRadius: BorderRadius.circular(25),
// // // //                 //             child: CachedNetworkImage(
// // // //                 //               imageUrl: category.imageUrl,
// // // //                 //               width: 50,
// // // //                 //               height: 50,
// // // //                 //               fit: BoxFit.cover,
// // // //                 //             ),
// // // //                 //           ),
// // // //                 //         ),
// // // //                 //         const SizedBox(height: 5),
// // // //                 //         Text(category.title,
// // // //                 //             textAlign: TextAlign.center,
// // // //                 //             style: TextStyle(fontSize: 12)),
// // // //                 //       ],
// // // //                 //     ),
// // // //                 //   ),
// // // //                 // );
// // // //               },
// // // //             ),
// // // //           ),
// // // //           // 📌 Product Grid (Right Side)
// // // //           Expanded(
// // // //             child: productState.isLoading
// // // //                 ? Center(child: CircularProgressIndicator())
// // // //                 : productState.errorMessage != null
// // // //                     ? Center(child: Text('Error: ${productState.errorMessage}'))
// // // //                     : GridView.builder(
// // // //                         padding: const EdgeInsets.all(8),
// // // //                         itemCount: productState.products.length,
// // // //                         gridDelegate:
// // // //                             const SliverGridDelegateWithFixedCrossAxisCount(
// // // //                           crossAxisCount: 2,
// // // //                           childAspectRatio: 0.75,
// // // //                           crossAxisSpacing: 8,
// // // //                           mainAxisSpacing: 8,
// // // //                         ),
// // // //                         itemBuilder: (context, index) {
// // // //                           final product = productState.products[index];
// // // //                           return Card(
// // // //                             shape: RoundedRectangleBorder(
// // // //                                 borderRadius: BorderRadius.circular(12)),
// // // //                             elevation: 4,
// // // //                             child: Column(
// // // //                               crossAxisAlignment: CrossAxisAlignment.start,
// // // //                               children: [
// // // //                                 Expanded(
// // // //                                   child: ClipRRect(
// // // //                                     borderRadius: const BorderRadius.vertical(
// // // //                                         top: Radius.circular(12)),
// // // //                                     child: CachedNetworkImage(
// // // //                                       imageUrl: product.imageUrl,
// // // //                                       width: double.infinity,
// // // //                                       fit: BoxFit.cover,
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                                 Padding(
// // // //                                   padding: const EdgeInsets.all(8.0),
// // // //                                   child: Text(product.title,
// // // //                                       style: const TextStyle(
// // // //                                           fontWeight: FontWeight.bold)),
// // // //                                 ),
// // // //                                 Padding(
// // // //                                   padding: const EdgeInsets.symmetric(
// // // //                                       horizontal: 8.0),
// // // //                                   child: Row(
// // // //                                     children: [
// // // //                                       Text('₹${product.price}',
// // // //                                           style: const TextStyle(
// // // //                                               color: Colors.green,
// // // //                                               fontWeight: FontWeight.bold)),
// // // //                                       const SizedBox(width: 5),
// // // //                                       Text('₹${product.discountPrice}',
// // // //                                           style: const TextStyle(
// // // //                                               decoration:
// // // //                                                   TextDecoration.lineThrough,
// // // //                                               color: Colors.grey)),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           );
// // // //                         },
// // // //                       ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       floatingActionButton: FloatingActionButton(
// // // //         onPressed: () =>
// // // //             ref.read(productProvider.notifier).fetchProducts(page: 1),
// // // //         child: Icon(Icons.refresh),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import 'package:cached_network_image/cached_network_image.dart';
// // // import 'package:dio/dio.dart';
// // // import '../services/category_list_services.dart';
// // // import '../models/category_list_model.dart';

// // // // ✅ API Service Provider
// // // final apiServiceProvider = Provider<ApiService>((ref) {
// // //   return ApiService(Dio());
// // // });

// // // // ✅ Product State
// // // class ProductState {
// // //   final List<Product> products;
// // //   final List<Category> categories;
// // //   final String? selectedCategoryId;
// // //   final bool isLoading;
// // //   final String? errorMessage;

// // //   ProductState({
// // //     required this.products,
// // //     required this.categories,
// // //     required this.selectedCategoryId,
// // //     required this.isLoading,
// // //     this.errorMessage,
// // //   });

// // //   ProductState copyWith({
// // //     List<Product>? products,
// // //     List<Category>? categories,
// // //     String? selectedCategoryId,
// // //     bool? isLoading,
// // //     String? errorMessage,
// // //   }) {
// // //     return ProductState(
// // //       products: products ?? this.products,
// // //       categories: categories ?? this.categories,
// // //       selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
// // //       isLoading: isLoading ?? this.isLoading,
// // //       errorMessage: errorMessage ?? this.errorMessage,
// // //     );
// // //   }
// // // }

// // // // ✅ Product Notifier
// // // class ProductNotifier extends StateNotifier<ProductState> {
// // //   final ApiService _apiService;

// // //   ProductNotifier(this._apiService)
// // //       : super(ProductState(
// // //             products: [],
// // //             categories: [],
// // //             selectedCategoryId: null,
// // //             isLoading: true)) {
// // //     fetchProducts(page: 1);
// // //   }

// // //   Future<void> fetchProducts({String? categoryId, required int page}) async {
// // //     state = state.copyWith(
// // //         isLoading: true, errorMessage: null, selectedCategoryId: categoryId);
// // //     try {
// // //       final response =
// // //           await _apiService.fetchProducts(categoryId: categoryId, page: page);
// // //       state = state.copyWith(
// // //         products: response.products,
// // //         categories: response.categories.isNotEmpty
// // //             ? response.categories
// // //             : state.categories,
// // //         isLoading: false,
// // //       );
// // //     } catch (e) {
// // //       state = state.copyWith(isLoading: false, errorMessage: e.toString());
// // //     }
// // //   }
// // // }

// // // // ✅ Product Provider
// // // final productProvider =
// // //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// // //   final apiService = ref.read(apiServiceProvider);
// // //   return ProductNotifier(apiService);
// // // });

// // // class ProductListView extends ConsumerWidget {
// // //   @override
// // //   Widget build(BuildContext context, WidgetRef ref) {
// // //     final productState = ref.watch(productProvider);

// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Vegetables & Fruits')),
// // //       body: Column(
// // //         children: [
// // //           // 📌 Always Visible Category List
// // //           CategoryListView(ref),

// // //           // 📌 Product Grid (Right Side)
// // //           Expanded(
// // //             child: productState.isLoading
// // //                 ? Center(child: CircularProgressIndicator())
// // //                 : productState.errorMessage != null
// // //                     ? Center(child: Text('Error: ${productState.errorMessage}'))
// // //                     : ProductGridView(ref),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // ✅ Category View
// // // Widget CategoryListView(WidgetRef ref) {
// // //   final productState = ref.watch(productProvider);
// // //   return SizedBox(
// // //     height: 100,
// // //     child: ListView.builder(
// // //       scrollDirection: Axis.horizontal,
// // //       itemCount: productState.categories.length,
// // //       itemBuilder: (context, index) {
// // //         final category = productState.categories[index];
// // //         return GestureDetector(
// // //           onTap: () {
// // //             ref
// // //                 .read(productProvider.notifier)
// // //                 .fetchProducts(categoryId: category.id, page: 1);
// // //           },
// // //           child: Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 10),
// // //             child: Column(
// // //               children: [
// // //                 CircleAvatar(
// // //                   backgroundImage:
// // //                       CachedNetworkImageProvider(category.imageUrl),
// // //                   radius: 30,
// // //                 ),
// // //                 const SizedBox(height: 5),
// // //                 Text(category.title,
// // //                     textAlign: TextAlign.center,
// // //                     style: TextStyle(fontSize: 14)),
// // //               ],
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     ),
// // //   );
// // // }

// // // // ✅ Product Grid View
// // // Widget ProductGridView(WidgetRef ref) {
// // //   final productState = ref.watch(productProvider);
// // //   return GridView.builder(
// // //     padding: const EdgeInsets.all(8),
// // //     itemCount: productState.products.length,
// // //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //       crossAxisCount: 2,
// // //       childAspectRatio: 0.75,
// // //       crossAxisSpacing: 8,
// // //       mainAxisSpacing: 8,
// // //     ),
// // //     itemBuilder: (context, index) {
// // //       final product = productState.products[index];
// // //       return Card(
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //         elevation: 4,
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Expanded(
// // //               child: ClipRRect(
// // //                 borderRadius:
// // //                     const BorderRadius.vertical(top: Radius.circular(12)),
// // //                 child: CachedNetworkImage(
// // //                   imageUrl: product.imageUrl,
// // //                   width: double.infinity,
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //               ),
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Text(product.title,
// // //                   style: const TextStyle(fontWeight: FontWeight.bold)),
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //     },
// // //   );
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import 'package:cached_network_image/cached_network_image.dart';
// // // import 'package:dio/dio.dart';
// // // import '../services/category_list_services.dart';
// // // import '../models/category_list_model.dart';

// // // // ✅ API Service Provider
// // // final apiServiceProvider = Provider<ApiService>((ref) {
// // //   return ApiService(Dio());
// // // });

// // // // ✅ Product State
// // // class ProductState {
// // //   final List<Product> products;
// // //   final List<Category> categories;
// // //   final String? selectedCategoryId;
// // //   final bool isLoading;
// // //   final String? errorMessage;

// // //   ProductState({
// // //     required this.products,
// // //     required this.categories,
// // //     required this.selectedCategoryId,
// // //     required this.isLoading,
// // //     this.errorMessage,
// // //   });

// // //   ProductState copyWith({
// // //     List<Product>? products,
// // //     List<Category>? categories,
// // //     String? selectedCategoryId,
// // //     bool? isLoading,
// // //     String? errorMessage,
// // //   }) {
// // //     return ProductState(
// // //       products: products ?? this.products,
// // //       categories: categories ?? this.categories,
// // //       selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
// // //       isLoading: isLoading ?? this.isLoading,
// // //       errorMessage: errorMessage ?? this.errorMessage,
// // //     );
// // //   }
// // // }

// // // // ✅ Product Notifier
// // // class ProductNotifier extends StateNotifier<ProductState> {
// // //   final ApiService _apiService;

// // //   ProductNotifier(this._apiService)
// // //       : super(ProductState(
// // //             products: [],
// // //             categories: [],
// // //             selectedCategoryId: null,
// // //             isLoading: true)) {
// // //     fetchProducts(page: 1);
// // //   }

// // //   Future<void> fetchProducts({String? categoryId, required int page}) async {
// // //     state = state.copyWith(
// // //         isLoading: true, errorMessage: null, selectedCategoryId: categoryId);
// // //     try {
// // //       final response =
// // //           await _apiService.fetchProducts(categoryId: categoryId, page: page);
// // //       state = state.copyWith(
// // //         products: response.products,
// // //         categories: response.categories.isNotEmpty
// // //             ? response.categories
// // //             : state.categories,
// // //         isLoading: false,
// // //       );
// // //     } catch (e) {
// // //       state = state.copyWith(isLoading: false, errorMessage: e.toString());
// // //     }
// // //   }
// // // }

// // // // ✅ Product Provider
// // // final productProvider =
// // //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// // //   final apiService = ref.read(apiServiceProvider);
// // //   return ProductNotifier(apiService);
// // // });

// // // class ProductListView extends ConsumerWidget {
// // //   @override
// // //   Widget build(BuildContext context, WidgetRef ref) {
// // //     final productState = ref.watch(productProvider);

// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Vegetables & Fruits')),
// // //       body: Row(
// // //         children: [
// // //           // 📌 Always Visible Vertical Category List
// // //           CategoryListView(ref),

// // //           // 📌 Product Grid (Right Side)
// // //           Expanded(
// // //             child: productState.isLoading
// // //                 ? Center(child: CircularProgressIndicator())
// // //                 : productState.errorMessage != null
// // //                     ? Center(child: Text('Error: ${productState.errorMessage}'))
// // //                     : ProductGridView(ref),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // ✅ Vertical Category View
// // // Widget CategoryListView(WidgetRef ref) {
// // //   final productState = ref.watch(productProvider);
// // //   return SizedBox(
// // //     width: 100, // Adjust width as needed
// // //     child: ListView.builder(
// // //       itemCount: productState.categories.length,
// // //       itemBuilder: (context, index) {
// // //         final category = productState.categories[index];
// // //         return GestureDetector(
// // //           onTap: () {
// // //             ref
// // //                 .read(productProvider.notifier)
// // //                 .fetchProducts(categoryId: category.id, page: 1);
// // //           },
// // //           child: Padding(
// // //             padding: const EdgeInsets.symmetric(vertical: 10),
// // //             child: Column(
// // //               children: [
// // //                 Container(
// // //                   padding: const EdgeInsets.all(8),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.green, // Highlight selected category
// // //                     borderRadius: BorderRadius.circular(50),
// // //                   ),
// // //                   child: ClipRRect(
// // //                     borderRadius: BorderRadius.circular(25),
// // //                     child: CachedNetworkImage(
// // //                       imageUrl: category.imageUrl,
// // //                       width: 50,
// // //                       height: 50,
// // //                       fit: BoxFit.cover,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 5),
// // //                 Text(category.title,
// // //                     textAlign: TextAlign.center,
// // //                     style: TextStyle(fontSize: 12)),
// // //               ],
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     ),
// // //   );
// // // }

// // // // ✅ Product Grid View
// // // Widget ProductGridView(WidgetRef ref) {
// // //   final productState = ref.watch(productProvider);
// // //   return GridView.builder(
// // //     padding: const EdgeInsets.all(8),
// // //     itemCount: productState.products.length,
// // //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //       crossAxisCount: 2,
// // //       childAspectRatio: 0.75,
// // //       crossAxisSpacing: 8,
// // //       mainAxisSpacing: 8,
// // //     ),
// // //     itemBuilder: (context, index) {
// // //       final product = productState.products[index];
// // //       return Card(
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //         elevation: 4,
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Expanded(
// // //               child: ClipRRect(
// // //                 borderRadius:
// // //                     const BorderRadius.vertical(top: Radius.circular(12)),
// // //                 child: CachedNetworkImage(
// // //                   imageUrl: product.imageUrl,
// // //                   width: double.infinity,
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //               ),
// // //             ),
// // //             Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: Text(product.title,
// // //                   style: const TextStyle(fontWeight: FontWeight.bold)),
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //     },
// // //   );
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:dio/dio.dart';
// // import '../services/category_list_services.dart';
// // import '../models/category_list_model.dart';

// // // ✅ API Service Provider
// // final apiServiceProvider = Provider<ApiService>((ref) {
// //   return ApiService(Dio());
// // });

// // // ✅ Product State
// // class ProductState {
// //   final List<Product> products;
// //   final List<Category> categories;
// //   final String? selectedCategoryId;
// //   final bool isLoading;
// //   final bool isLoadingMore;
// //   final int currentPage;
// //   final String? errorMessage;

// //   ProductState({
// //     required this.products,
// //     required this.categories,
// //     required this.selectedCategoryId,
// //     required this.isLoading,
// //     required this.isLoadingMore,
// //     required this.currentPage,
// //     this.errorMessage,
// //   });

// //   ProductState copyWith({
// //     List<Product>? products,
// //     List<Category>? categories,
// //     String? selectedCategoryId,
// //     bool? isLoading,
// //     bool? isLoadingMore,
// //     int? currentPage,
// //     String? errorMessage,
// //   }) {
// //     return ProductState(
// //       products: products ?? this.products,
// //       categories: categories ?? this.categories,
// //       selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
// //       isLoading: isLoading ?? this.isLoading,
// //       isLoadingMore: isLoadingMore ?? this.isLoadingMore,
// //       currentPage: currentPage ?? this.currentPage,
// //       errorMessage: errorMessage ?? this.errorMessage,
// //     );
// //   }
// // }

// // // ✅ Product Notifier
// // class ProductNotifier extends StateNotifier<ProductState> {
// //   final ApiService _apiService;

// //   ProductNotifier(this._apiService)
// //       : super(ProductState(
// //             products: [],
// //             categories: [],
// //             selectedCategoryId: null,
// //             isLoading: true,
// //             isLoadingMore: false,
// //             currentPage: 1)) {
// //     fetchProducts(page: 1);
// //   }

// //   Future<void> fetchProducts({String? categoryId, required int page}) async {
// //     if (page == 1) {
// //       state = state.copyWith(
// //           isLoading: true,
// //           errorMessage: null,
// //           selectedCategoryId: categoryId,
// //           currentPage: page);
// //     } else {
// //       state = state.copyWith(
// //           isLoadingMore: true, errorMessage: null, currentPage: page);
// //     }
// //     try {
// //       final response =
// //           await _apiService.fetchProducts(categoryId: categoryId, page: page);
// //       state = state.copyWith(
// //         products: page == 1
// //             ? response.products
// //             : [...state.products, ...response.products],
// //         categories: response.categories.isNotEmpty
// //             ? response.categories
// //             : state.categories,
// //         isLoading: false,
// //         isLoadingMore: false,
// //       );
// //     } catch (e) {
// //       state = state.copyWith(
// //           isLoading: false, isLoadingMore: false, errorMessage: e.toString());
// //     }
// //   }
// // }

// // // ✅ Product Provider
// // final productProvider =
// //     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
// //   final apiService = ref.read(apiServiceProvider);
// //   return ProductNotifier(apiService);
// // });

// // class ProductListView extends ConsumerWidget {
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final productState = ref.watch(productProvider);

// //     return Scaffold(
// //       appBar: AppBar(title: Text('Vegetables & Fruits')),
// //       body: Row(
// //         children: [
// //           // 📌 Always Visible Vertical Category List
// //           CategoryListView(ref),

// //           // 📌 Product Grid (Right Side)
// //           Expanded(
// //             child: productState.isLoading
// //                 ? Center(child: CircularProgressIndicator())
// //                 : productState.errorMessage != null
// //                     ? Center(child: Text('Error: ${productState.errorMessage}'))
// //                     : ProductGridView(ref),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ✅ Vertical Category View
// // Widget CategoryListView(WidgetRef ref) {
// //   final productState = ref.watch(productProvider);
// //   return SizedBox(
// //     width: 100, // Adjust width as needed
// //     child: ListView.builder(
// //       itemCount: productState.categories.length,
// //       itemBuilder: (context, index) {
// //         final category = productState.categories[index];
// //         return GestureDetector(
// //           onTap: () {
// //             ref
// //                 .read(productProvider.notifier)
// //                 .fetchProducts(categoryId: category.id, page: 1);
// //           },
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(vertical: 10),
// //             child: Column(
// //               children: [
// //                 Container(
// //                   padding: const EdgeInsets.all(8),
// //                   decoration: BoxDecoration(
// //                     color: Colors.green, // Highlight selected category
// //                     borderRadius: BorderRadius.circular(50),
// //                   ),
// //                   child: ClipRRect(
// //                     borderRadius: BorderRadius.circular(25),
// //                     child: CachedNetworkImage(
// //                       imageUrl: category.imageUrl,
// //                       width: 50,
// //                       height: 50,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 5),
// //                 Text(category.title,
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(fontSize: 12)),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     ),
// //   );
// // }

// // // ✅ Product Grid View with Pagination
// // Widget ProductGridView(WidgetRef ref) {
// //   final productState = ref.watch(productProvider);
// //   return NotificationListener<ScrollNotification>(
// //     onNotification: (ScrollNotification scrollInfo) {
// //       if (!productState.isLoadingMore &&
// //           scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
// //         ref.read(productProvider.notifier).fetchProducts(
// //             categoryId: productState.selectedCategoryId,
// //             page: productState.currentPage + 1);
// //       }
// //       return true;
// //     },
// //     child: GridView.builder(
// //       padding: const EdgeInsets.all(8),
// //       itemCount:
// //           productState.products.length + (productState.isLoadingMore ? 1 : 0),
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         childAspectRatio: 0.75,
// //         crossAxisSpacing: 8,
// //         mainAxisSpacing: 8,
// //       ),
// //       itemBuilder: (context, index) {
// //         if (index == productState.products.length) {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //         final product = productState.products[index];
// //         return Card(
// //           shape:
// //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //           elevation: 4,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Expanded(
// //                 child: ClipRRect(
// //                   borderRadius:
// //                       const BorderRadius.vertical(top: Radius.circular(12)),
// //                   child: CachedNetworkImage(
// //                     imageUrl: product.imageUrl,
// //                     width: double.infinity,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Text(product.title,
// //                     style: const TextStyle(fontWeight: FontWeight.bold)),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     ),
// //   );
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dio/dio.dart';
// import '../services/category_list_services.dart';
// import '../models/category_list_model.dart';

// // ✅ API Service Provider
// final apiServiceProvider = Provider<ApiService>((ref) {
//   return ApiService(Dio());
// });

// // ✅ Product State
// class ProductState {
//   final List<Product> products;
//   final List<Category> categories;
//   final String? selectedCategoryId;
//   final bool isLoading;
//   final bool isLoadingMore;
//   final int currentPage;
//   final String? errorMessage;

//   ProductState({
//     required this.products,
//     required this.categories,
//     required this.selectedCategoryId,
//     required this.isLoading,
//     required this.isLoadingMore,
//     required this.currentPage,
//     this.errorMessage,
//   });

//   ProductState copyWith({
//     List<Product>? products,
//     List<Category>? categories,
//     String? selectedCategoryId,
//     bool? isLoading,
//     bool? isLoadingMore,
//     int? currentPage,
//     String? errorMessage,
//   }) {
//     return ProductState(
//       products: products ?? this.products,
//       categories: categories ?? this.categories,
//       selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
//       isLoading: isLoading ?? this.isLoading,
//       isLoadingMore: isLoadingMore ?? this.isLoadingMore,
//       currentPage: currentPage ?? this.currentPage,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }
// }

// // ✅ Product Notifier
// class ProductNotifier extends StateNotifier<ProductState> {
//   final ApiService _apiService;

//   ProductNotifier(this._apiService)
//       : super(ProductState(
//             products: [],
//             categories: [],
//             selectedCategoryId: null,
//             isLoading: true,
//             isLoadingMore: false,
//             currentPage: 1)) {
//     fetchProducts(page: 1);
//   }

//   Future<void> fetchProducts({String? categoryId, required int page}) async {
//     if (page == 1) {
//       state = state.copyWith(
//           isLoading: true,
//           errorMessage: null,
//           selectedCategoryId: categoryId,
//           currentPage: page);
//     } else {
//       state = state.copyWith(
//           isLoadingMore: true, errorMessage: null, currentPage: page);
//     }
//     try {
//       final response =
//           await _apiService.fetchProducts(categoryId: categoryId, page: page);
//       state = state.copyWith(
//         products: page == 1
//             ? response.products
//             : [...state.products, ...response.products],
//         categories: response.categories.isNotEmpty
//             ? response.categories
//             : state.categories,
//         isLoading: false,
//         isLoadingMore: false,
//       );
//     } catch (e) {
//       state = state.copyWith(
//           isLoading: false, isLoadingMore: false, errorMessage: e.toString());
//     }
//   }
// }

// // ✅ Product Provider
// final productProvider =
//     StateNotifierProvider<ProductNotifier, ProductState>((ref) {
//   final apiService = ref.read(apiServiceProvider);
//   return ProductNotifier(apiService);
// });

// class ProductListView extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productState = ref.watch(productProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text('Vegetables & Fruits')),
//       body: Row(
//         children: [
//           // 📌 Always Visible Vertical Category List
//           CategoryListView(ref),

//           // 📌 Product Grid (Right Side)
//           Expanded(
//             child: productState.isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : productState.errorMessage != null
//                     ? Center(child: Text('Error: ${productState.errorMessage}'))
//                     : ProductGridView(ref),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ✅ Vertical Category View
// Widget CategoryListView(WidgetRef ref) {
//   final productState = ref.watch(productProvider);
//   return SizedBox(
//     width: 100, // Adjust width as needed
//     child: ListView.builder(
//       itemCount: productState.categories.length,
//       itemBuilder: (context, index) {
//         final category = productState.categories[index];
//         final isSelected = category.id == productState.selectedCategoryId;
//         return GestureDetector(
//           onTap: () {
//             ref
//                 .read(productProvider.notifier)
//                 .fetchProducts(categoryId: category.id, page: 1);
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: isSelected
//                         ? Colors.blue
//                         : Colors.green, // Highlight selected category
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(25),
//                     child: CachedNetworkImage(
//                       imageUrl: category.imageUrl,
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(category.title,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           ),
//         );
//       },
//     ),
//   );
// }

// // ✅ Product Grid View with Pagination
// Widget ProductGridView(WidgetRef ref) {
//   final productState = ref.watch(productProvider);
//   return NotificationListener<ScrollNotification>(
//     onNotification: (ScrollNotification scrollInfo) {
//       if (!productState.isLoadingMore &&
//           scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//         ref.read(productProvider.notifier).fetchProducts(
//             categoryId: productState.selectedCategoryId,
//             page: productState.currentPage + 1);
//       }
//       return true;
//     },
//     child: GridView.builder(
//       padding: const EdgeInsets.all(8),
//       itemCount:
//           productState.products.length + (productState.isLoadingMore ? 1 : 0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.75,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//       ),
//       itemBuilder: (context, index) {
//         if (index == productState.products.length) {
//           return Center(child: CircularProgressIndicator());
//         }
//         final product = productState.products[index];
//         return Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           elevation: 4,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(12)),
//                   child: CachedNetworkImage(
//                     imageUrl: product.imageUrl,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(product.title,
//                     style: const TextStyle(fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

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
