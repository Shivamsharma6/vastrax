class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final List<String> sizes;
  final String category;
  final String? subCategory;
  final bool isNew;
  final bool isTrending;
  final Map<String, int> stockBySize;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.sizes,
    required this.category,
    this.subCategory,
    this.isNew = false,
    this.isTrending = false,
    this.stockBySize = const {},
  });

  Map<String, dynamic> toFirestore() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'images': images,
        'sizes': sizes,
        'category': category,
        'subCategory': subCategory,
        'isNew': isNew,
        'isTrending': isTrending,
        'stockBySize': stockBySize,
       };

  factory ProductModel.fromFirestore(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      images: List<String>.from(data['images'] ?? []),
      sizes: List<String>.from(data['sizes'] ?? []),
      category: data['category'] ?? '',
      subCategory: data['subCategory'],
      isNew: data['isNew'] ?? false,
      isTrending: data['isTrending'] ?? false,
      stockBySize: Map<String, int>.from(data['stockBySize'] ?? {}),
     );
  }
}
