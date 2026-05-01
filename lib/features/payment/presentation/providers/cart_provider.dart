import 'package:flutter/material.dart';
import '../../domain/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere(
       (e) => e.productId == item.productId && e.size == item.size,
       );
    
    if (existingIndex != -1) {
      _items[existingIndex].quantity += item.quantity;
      } else {
        _items.add(item);
        }
    
    notifyListeners();
   }

  void removeItem(String productId, String size) {
     _items.removeWhere((e) => e.productId == productId && e.size == size);
    notifyListeners();
   }

  void updateQuantity(String productId, String size, int quantity) {
    if (quantity <= 0) {
       removeItem(productId, size);
      return;
     }
    
    final item = _items.firstWhere(
       (e) => e.productId == productId && e.size == size,
      );
    item.quantity = quantity;
    notifyListeners();
   }

  void clearCart() {
     _items.clear();
    notifyListeners();
   }
}
