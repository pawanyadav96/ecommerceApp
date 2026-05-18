import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),

      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          if (provider.cartItems.isEmpty) {
            return const Center(child: Text('Cart Is Empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.cartItems.length,

                  itemBuilder: (context, index) {
                    final item = provider.cartItems[index];

                    return Card(
                      margin: const EdgeInsets.all(10),

                      child: Padding(
                        padding: const EdgeInsets.all(12),

                        child: Row(
                          children: [
                            Image.network(
                              item.product.thumbnail,

                              height: 80,

                              width: 80,

                              fit: BoxFit.cover,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    item.product.title,

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text('₹ ${item.product.price}'),

                                  const SizedBox(height: 10),

                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          provider.decreaseQuantity(
                                            item.product.id,
                                          );
                                        },

                                        icon: const Icon(Icons.remove),
                                      ),

                                      Text(item.quantity.toString()),

                                      IconButton(
                                        onPressed: () {
                                          provider.increaseQuantity(
                                            item.product.id,
                                          );
                                        },

                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                provider.removeItem(item.product.id);
                              },

                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(color: Colors.grey.shade200),

                child: Column(
                  children: [
                    priceRow('Total Items', provider.totalItems.toString()),

                    priceRow(
                      'Subtotal',
                      '₹ ${provider.subtotal.toStringAsFixed(2)}',
                    ),

                    priceRow(
                      'Discount',
                      '₹ ${provider.totalDiscount.toStringAsFixed(2)}',
                    ),

                    const Divider(),

                    priceRow(
                      'Final Amount',
                      '₹ ${provider.finalAmount.toStringAsFixed(2)}',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget priceRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: const TextStyle(fontSize: 16)),

          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
