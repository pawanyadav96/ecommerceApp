import 'package:flutter/material.dart';

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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Price: ₹ ${product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Discounted Price: ₹ ${discountedPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, color: Colors.green),
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
    );
  }
}
