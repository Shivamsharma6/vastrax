import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../payment/presentation/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

    @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Bag'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
         ),
        actions: [
          TextButton(
            onPressed: cart.items.isEmpty ? null : () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Clear Bag'),
                  content: const Text('Remove all items from your bag?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                     ),
                    TextButton(
                      onPressed: () {
                        cart.clearCart();
                        Navigator.pop(context);
                       },
                      child: const Text('Clear', style: TextStyle(color: Colors.red)),
                     ),
                   ],
                 ),
               );
             },
            child: const Text('Clear All', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
           ),
         ],
       ),
      body: cart.items.isEmpty
           ? _buildEmptyState(context)
           : Column(
              children: [
                Expanded(child: _buildCartList(cart)),
                 _buildBottomBar(context, cart),
               ],
             ),
     );
   }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('Your bag is empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey.shade400)),
          const SizedBox(height: 8),
          Text('Add items to get started', style: TextStyle(color: Colors.grey.shade400)),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Shopping'),
           ),
         ],
       ),
     );
   }

  Widget _buildCartList(CartProvider cart) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        final item = cart.items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)],
             ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.image,
                      width: 90,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 90,
                        height: 110,
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.image_not_supported),
                       ),
                     ),
                   ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text('Size: ${item.size}', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                          const Spacer(),
                          Text(
                             'Rs.${item.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                           ),
                         ],
                       ),
                     ),
                   ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.grey),
                        onPressed: () => cart.removeItem(item.productId, item.size),
                       ),
                      Row(
                        children: [
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.remove, size: 16),
                             ),
                            onPressed: () => cart.updateQuantity(item.productId, item.size, item.quantity - 1),
                           ),
                          Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w600)),
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.add, size: 16),
                             ),
                            onPressed: () => cart.updateQuantity(item.productId, item.size, item.quantity + 1),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }

  Widget _buildBottomBar(BuildContext context, CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16)],
       ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: TextStyle(color: Colors.grey.shade600)),
              Text(
                 'Rs.${cart.totalAmount.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
               ),
             ],
           ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: cart.items.isEmpty ? null : () => Navigator.pushNamed(context, '/checkout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1A1A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
             ),
            child: Text('Checkout - Rs.${cart.totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
           ),
         ],
       ),
     );
   }
}
