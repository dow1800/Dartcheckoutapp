import 'product.dart';

/// Represents an item in the shopping cart
class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  /// Calculates the total price for this cart item
  double get totalPrice => product.price * quantity;

  /// Creates a CartItem from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  /// Converts this CartItem to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'CartItem(product: ${product.name}, quantity: $quantity, total: \$${totalPrice.toStringAsFixed(2)})';
  }
}
