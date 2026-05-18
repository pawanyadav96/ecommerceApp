import 'package:flutter/material.dart';

import '../../features/product/model/product_model.dart';

class ProductCard extends StatelessWidget {

  final ProductModel product;

  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

        onTap: onTap,

        child: Card(

          margin:
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),

            child: Padding(

              padding: const EdgeInsets.all(12),

              child: Row(

                  children: [

              ClipRRect(

              borderRadius:
              BorderRadius.circular(12),

              child: Image.network(
                product.thumbnail,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(

                child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [
                  Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

              const SizedBox(height: 8),

              Text(
                'Brand: ${product.brand}',
              ),

              const SizedBox(height: 5),

              Text(
                '₹ ${product.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Discount: ${product.discountPercentage.toStringAsFixed(1)}%',
              ),

              const SizedBox(height: 5),
                Row(

                  children: [

                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 18,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      product.rating.toString(),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                    product.stock > 0
                        ? 'In Stock'
                        : 'Out Of Stock',
                    style: TextStyle(
                      color: product.stock > 0
                          ? Colors.green
                          : Colors.red,
                    ),
                ),
                    ],
                ),
            ),
                  ],
              ),
            ),
        ),
    );
  }
}