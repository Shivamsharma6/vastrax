import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../features/product/domain/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: product.images.first,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      height: 220,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    ),
                    errorWidget: (_, _, _) => Container(
                      height: 220,
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.error_outline, size: 40),
                    ),
                  ),
                ),
                if (product.isNew)
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8)],
                      ),
                      child: const Text('NEW', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1)),
                    ),
                  ),
                if (product.isTrending)
                  Positioned(
                    top: 8, right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFC9A87C), borderRadius: BorderRadius.circular(20)),
                      child: const Text('\u{1F525}', style: TextStyle(fontSize: 12)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              product.category,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500, letterSpacing: 0.5),
            ),
            const Spacer(),
            Row(
              children: [
                Text('Rs.${product.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A))),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(50)),
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
