import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../../payment/domain/models/cart_item.dart';
import '../../../payment/presentation/providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;

  ProductModel get product => context.read<ProductRepository>().getProductById(widget.productId);

   @override
  void initState() {
    super.initState();      }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    _buildImageSection(),
                  const SizedBox(height: 24),
                   _buildProductInfo(),
                  const SizedBox(height: 32),
                   _buildSizeSelector(),
                  const SizedBox(height: 32),
                   _buildDescription(),
                  const SizedBox(height: 100),
                 ],
               ),
             ),
           ),
          _buildBottomBar(context),
         ],
        ),
      );
     }

  Widget _buildImageSection() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      child: CachedNetworkImage(
        imageUrl: product.images.first,
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, _) => Container(height: 400, color: Colors.grey.shade100),
        errorWidget: (_, _, _) => Container(
          height: 400, color: Colors.grey.shade100,
          child: const Icon(Icons.error_outline, size: 60),
         ),
       ),
      );
     }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1A)), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Row(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(20)), child: Text(product.category, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey.shade700))),
            ],
           ),
          ],
         ),
       );
      }

  Widget _buildSizeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Size', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
          const SizedBox(height: 12),
          Row(children: product.sizes.map((size) {
            final isSelected = _selectedSize == size;
            return Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: GestureDetector(
              onTap: () => setState(() => _selectedSize = size),
              child: Container(padding: const EdgeInsets.symmetric(vertical: 14), decoration: BoxDecoration(color: isSelected ? const Color(0xFF1A1A1A) : Colors.white, border: Border.all(color: isSelected ? const Color(0xFF1A1A1A) : Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(size, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF1A1A1A), fontWeight: FontWeight.w600, fontSize: 14), textAlign: TextAlign.center)),
               ),
             ),
            ));
          }).toList()),
         ],
        ),
      );
     }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
          const SizedBox(height: 8),
          Text(product.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.6), textAlign: TextAlign.justify),
         ],
        ),
      );
     }

  void _addToCart(BuildContext context) {
    if (_selectedSize == null) return;
    final cartItem = CartItem(productId: product.id, productName: product.name, price: product.price, image: product.images.first, size: _selectedSize!, quantity: 1);
    context.read<CartProvider>().addItem(cartItem);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Added to cart'), behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), backgroundColor: const Color(0xFF1A1A1A), duration: const Duration(seconds: 2)));
     }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20)]),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Rs.${product.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          Text('Inclusive of all taxes', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
         ],),
        const Spacer(),
        ElevatedButton(onPressed: _selectedSize == null ? null : () => _addToCart(context), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A1A1A), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.w600))),
        ],
       ),
      );
     }
   }
