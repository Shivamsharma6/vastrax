import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/product_model.dart';

class ProductRepository extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProducts() async {
      _isLoading = true;
    notifyListeners();
    
    try {
       final snapshot = await _firestore.collection('products').get();
        _products = snapshot.docs
           .map((doc) => ProductModel.fromFirestore(doc.data(), doc.id))
           .toList();
       _error = null;
      } catch (e) {
       _error = e.toString();
      } finally {
       _isLoading = false;
      notifyListeners();
      }
     }

  ProductModel getProductById(String id) {
    return _products.firstWhere(
        (p) => p.id == id,
      orElse: () => throw Exception('Product not found'),
       );
    }

  List<ProductModel> getNewArrivals() {
    return _products.where((p) => p.isNew).toList();
     }

  List<ProductModel> getTrendingProducts() {
    return _products.where((p) => p.isTrending).toList();
     }

  List<ProductModel> getByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
     }
}
