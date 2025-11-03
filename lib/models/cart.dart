import 'cart_item.dart';
import 'product.dart';

/// Represents a shopping cart
class Cart {
  final List<CartItem> _items = [];

  /// Gets all items in the cart
  List<CartItem> get items => List.unmodifiable(_items);

  /// Gets the total number of items in the cart
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Calculates the subtotal of all items
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  /// Calculates tax (assumed 10% for this example)
  double get tax => subtotal * 0.10;

  /// Calculates the total amount including tax
  double get total => subtotal + tax;

  /// Adds a product to the cart
  void addProduct(Product product, {int quantity = 1}) {
    final existingItemIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
  }

  /// Removes a product from the cart
  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  /// Updates the quantity of a product in the cart
  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeProduct(productId);
      return;
    }

    final itemIndex = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (itemIndex >= 0) {
      _items[itemIndex].quantity = quantity;
    }
  }

  /// Clears all items from the cart
  void clear() {
    _items.clear();
  }

  /// Checks if the cart is empty
  bool get isEmpty => _items.isEmpty;

  /// Checks if the cart is not empty
  bool get isNotEmpty => _items.isNotEmpty;

  @override
  String toString() {
    return 'Cart(items: ${_items.length}, subtotal: \$${subtotal.toStringAsFixed(2)}, total: \$${total.toStringAsFixed(2)})';
  }
}
