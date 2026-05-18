import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../features/product/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.thumbnail ?? '',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,

                  // If image fails to load
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.title,
                    ),
                    Text('Brand: ${product.brand}'),
                    Text('₹ ${product.price}', style: AppTextStyles.small),

                    Text(
                      'Discount: ${product.discountPercentage.toStringAsFixed(1)}%',
                    ),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 18),
                        Text(product.rating.toString()),
                      ],
                    ),
                    Text(
                      product.stock > 0 ? 'In Stock' : 'Out Of Stock',
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
      ),
    );
  }
}
