import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/product_card.dart';
import '../../cart/provider/cart_provider.dart';
import '../../cart/screens/cart_screen.dart';
import '../provider/product_provider.dart';
import 'product_details_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().fetchProducts();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        context.read<ProductProvider>().fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),

        actions: [

          Consumer<CartProvider>(

            builder: (context, cartProvider, child) {

              return Stack(

                children: [

                  IconButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const CartScreen(),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),

                  if (cartProvider!.totalItems > 0)

                    Positioned(

                      right: 5,
                      top: 5,

                      child: Container(

                        padding:
                        const EdgeInsets.all(4),

                        decoration: const BoxDecoration(

                          color: Colors.red,

                          shape: BoxShape.circle,
                        ),

                        child: Text(

                          cartProvider!.totalItems
                              .toString(),

                          style: const TextStyle(

                            color: Colors.white,

                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.sort),

            onSelected: (value) {
              context.read<ProductProvider>().sortProducts(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'low',
                child: Text('Price Low to High'),
              ),

              const PopupMenuItem(
                value: 'high',
                child: Text('Price High to Low'),
              ),

              const PopupMenuItem(value: 'rating', child: Text('Rating')),
            ],
          ),

          PopupMenuButton(
            icon: const Icon(Icons.filter_alt),

            onSelected: (value) {
              context.read<ProductProvider>().filterCategory(value);
            },

            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),

              const PopupMenuItem(value: 'beauty', child: Text('Beauty')),

              const PopupMenuItem(
                value: 'fragrances',
                child: Text('Fragrances'),
              ),

              const PopupMenuItem(value: 'furniture', child: Text('Furniture')),
            ],
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.fetchProducts(isRefresh: true);
            },

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),

                  child: TextField(
                    onChanged: (value) {
                      provider.searchProducts(value);
                    },

                    decoration: InputDecoration(
                      hintText: 'Search Products',

                      prefixIcon: const Icon(Icons.search),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,

                    itemCount: provider.filteredProducts.length + 1,

                    itemBuilder: (context, index) {
                      if (index == provider.filteredProducts.length) {
                        if (provider.isPaginationLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(16),

                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (!provider.hasMore) {
                          return const Padding(
                            padding: EdgeInsets.all(20),

                            child: Center(child: Text('No More Products')),
                          );
                        }

                        return const SizedBox();
                      }

                      final product = provider.filteredProducts[index];

                      return ProductCard(
                        product: product,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
