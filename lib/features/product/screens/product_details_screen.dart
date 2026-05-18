import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../cart/provider/cart_provider.dart';
import '../model/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.price - ((product.price * product.discountPercentage) / 100);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              height: 220,

              child: PageView.builder(
                itemCount: product.images.length,

                itemBuilder: (context, index) {
                  return Image.network(
                    product.images[index],
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    product.title,
                    style: AppTextStyles.heading
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: AppTextStyles.small,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Price: ₹ ${product.price}',
                    style:AppTextStyles.body,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Discounted Price: ₹ ${discountedPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.body.copyWith(color: Colors.green)
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange),

                      const SizedBox(width: 5),

                      Text(product.rating.toString()),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Text('Brand: ${product.brand}'),

                  const SizedBox(height: 10),

                  Text('Category: ${product.category}'),

                  const SizedBox(height: 10),

                  Text(
                    product.stock > 0 ? 'Available' : 'Out Of Stock',
                    style: TextStyle(
                      color: product.stock > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),

              blurRadius: 10,

              offset: const Offset(0, -2),
            ),
          ],
        ),

        child: ElevatedButton(
          onPressed: () {
            context.read<CartProvider>().addToCart(product);

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Added To Cart')));
          },

          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),

          child: const Text(
            'Add To Cart',
            style: AppTextStyles.title,
          ),
        ),
      ),
    );
  }
}
