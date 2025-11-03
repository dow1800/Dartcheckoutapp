import 'cart.dart';
import 'customer.dart';

/// Represents the status of an order
enum OrderStatus {
  pending,
  processing,
  completed,
  cancelled,
  refunded,
}

/// Represents a payment method
enum PaymentMethod {
  creditCard,
  debitCard,
  paypal,
  applePay,
  googlePay,
  cash,
}

/// Represents an order in the checkout system
class Order {
  final String id;
  final Customer customer;
  final Cart cart;
  final PaymentMethod paymentMethod;
  OrderStatus status;
  final DateTime createdAt;
  DateTime? completedAt;

  Order({
    required this.id,
    required this.customer,
    required this.cart,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Creates an Order from a JSON map
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      cart: _cartFromJson(json['cart'] as Map<String, dynamic>),
      paymentMethod: PaymentMethod.values.byName(json['paymentMethod'] as String),
      status: OrderStatus.values.byName(json['status'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }

  static Cart _cartFromJson(Map<String, dynamic> json) {
    final cart = Cart();
    // Simplified cart reconstruction - in a real app you'd want to properly restore the cart
    return cart;
  }

  /// Converts this Order to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer.toJson(),
      'cart': {
        'subtotal': cart.subtotal,
        'tax': cart.tax,
        'total': cart.total,
        'itemCount': cart.itemCount,
      },
      'paymentMethod': paymentMethod.name,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  /// Marks the order as completed
  void complete() {
    status = OrderStatus.completed;
    completedAt = DateTime.now();
  }

  /// Cancels the order
  void cancel() {
    status = OrderStatus.cancelled;
  }

  @override
  String toString() {
    return 'Order(id: $id, customer: ${customer.name}, total: \$${cart.total.toStringAsFixed(2)}, status: ${status.name})';
  }
}
