import '../interfaces/payment_processor.dart';
import '../models/cart.dart';
import '../models/customer.dart';
import '../models/order.dart';

/// Result of a checkout operation
class CheckoutResult {
  final bool success;
  final Order? order;
  final String? errorMessage;

  CheckoutResult({
    required this.success,
    this.order,
    this.errorMessage,
  });

  @override
  String toString() {
    if (success) {
      return 'CheckoutResult(success: true, orderId: ${order?.id})';
    } else {
      return 'CheckoutResult(success: false, error: $errorMessage)';
    }
  }
}

/// Main checkout service for processing orders
class CheckoutService {
  final PaymentProcessor paymentProcessor;
  final List<Order> _orders = [];

  CheckoutService({required this.paymentProcessor});

  /// Gets all orders
  List<Order> get orders => List.unmodifiable(_orders);

  /// Processes a checkout for the given cart and customer
  Future<CheckoutResult> checkout({
    required Cart cart,
    required Customer customer,
    required PaymentMethod paymentMethod,
    required Map<String, dynamic> paymentDetails,
  }) async {
    // Validate cart is not empty
    if (cart.isEmpty) {
      return CheckoutResult(
        success: false,
        errorMessage: 'Cart is empty',
      );
    }

    // Create order
    final order = Order(
      id: _generateOrderId(),
      customer: customer,
      cart: cart,
      paymentMethod: paymentMethod,
      status: OrderStatus.pending,
    );

    // Update order status to processing
    order.status = OrderStatus.processing;

    try {
      // Process payment
      final paymentResult = await paymentProcessor.processPayment(
        order,
        paymentDetails,
      );

      if (!paymentResult.success) {
        order.cancel();
        return CheckoutResult(
          success: false,
          errorMessage: 'Payment failed: ${paymentResult.errorMessage}',
        );
      }

      // Complete order
      order.complete();
      _orders.add(order);

      // Clear cart after successful checkout
      cart.clear();

      return CheckoutResult(
        success: true,
        order: order,
      );
    } catch (e) {
      order.cancel();
      return CheckoutResult(
        success: false,
        errorMessage: 'Checkout failed: $e',
      );
    }
  }

  /// Gets an order by ID
  Order? getOrder(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  /// Gets all orders for a specific customer
  List<Order> getOrdersByCustomer(String customerId) {
    return _orders
        .where((order) => order.customer.id == customerId)
        .toList();
  }

  /// Cancels an order
  bool cancelOrder(String orderId) {
    final order = getOrder(orderId);
    if (order == null) {
      return false;
    }

    if (order.status == OrderStatus.completed) {
      return false; // Cannot cancel completed orders
    }

    order.cancel();
    return true;
  }

  /// Generates a unique order ID
  String _generateOrderId() {
    return 'ORD_${DateTime.now().millisecondsSinceEpoch}';
  }
}
