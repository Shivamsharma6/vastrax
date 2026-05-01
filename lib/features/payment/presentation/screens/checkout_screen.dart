import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../payment/presentation/providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  String _paymentMethod = 'cod';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cart.items.isEmpty
          ? _buildEmptyState(context)
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildOrderSummary(cart),
                  const SizedBox(height: 24),
                  _buildDeliveryForm(),
                  const SizedBox(height: 24),
                  _buildPaymentMethods(),
                  const SizedBox(height: 100),
                  _buildPlaceOrderButton(context, cart),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('Nothing to checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey.shade400)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cart) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
          const Divider(height: 24),
          ...cart.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text('x${item.quantity}', style: TextStyle(color: Colors.grey.shade500)),
                    const SizedBox(width: 16),
                    Text(
                      'Rs.${item.totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )),
          Divider(height: 24),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping', style: TextStyle(color: Colors.grey.shade600)),
              Text('Free', style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.green)),
            ],
          ),
          Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Text(
                'Rs.${cart.totalAmount.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
            validator: (v) => v == null || v.length < 10 ? 'Valid phone required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Address'),
            maxLines: 3,
            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _pincodeController,
                  decoration: const InputDecoration(labelText: 'Pincode'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v == null || v.length < 6 ? 'Valid pincode required' : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
          const SizedBox(height: 16),
          _buildPaymentOption('cod', 'Cash on Delivery', Icons.money, 'Pay when you receive'),
          _buildPaymentOption('upi', 'UPI / Card / NetBanking', Icons.credit_card, 'All major payment methods'),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, String title, IconData icon, String subtitle) {
    final isSelected = _paymentMethod == value;
    return InkWell(
      onTap: () => setState(() => _paymentMethod = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: isSelected
                  ? const Center(child: Icon(Icons.check, size: 14, color: Colors.white))
                  : null,
            ),
            const SizedBox(width: 12),
            Icon(icon, size: 24, color: isSelected ? const Color(0xFF1A1A1A) : Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w500, color: isSelected ? const Color(0xFF1A1A1A) : Colors.grey.shade800)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context, CartProvider cart) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Order Placed!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
                  const SizedBox(height: 16),
                  const Text('Thank you for your order!', style: TextStyle(fontSize: 16)),
                  const Text(
                    'Order #VX123456',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    cart.clearCart();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Continue Shopping', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: const Text(
        'Place Order',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }
}
