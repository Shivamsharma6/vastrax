class CartItem {
  final String productId;
  final String productName;
  final double price;
  final String image;
  final String size;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.image,
    required this.size,
     this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toFirestore() => {
         'productId': productId,
         'productName': productName,
         'price': price,
         'image': image,
         'size': size,
         'quantity': quantity,
        };

  factory CartItem.fromFirestore(Map<String, dynamic> data) {
    return CartItem(
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      size: data['size'] ?? 'M',
      quantity: data['quantity'] ?? 1,
      );
  }
}
