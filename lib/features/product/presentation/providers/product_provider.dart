import 'package:flutter/material.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider() : _repository = ProductRepository() {
    _repository.addListener(notifyListeners);
    _repository.loadProducts();
     }

  List<ProductModel> get products => _repository.products;
  List<ProductModel> getNewArrivals() => _repository.getNewArrivals();
  List<ProductModel> getTrendingProducts() => _repository.getTrendingProducts();

  List<String> get categories => [
          'All',
          ..._repository.products.map((p) => p.category).toSet(),
         ];

  bool get isLoading => _repository.isLoading;
  String? get error => _repository.error;
}
