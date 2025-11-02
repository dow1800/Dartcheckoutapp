import '../models/order.dart';

/// Result of a payment transaction
class PaymentResult {
  final bool success;
  final String? transactionId;
  final String? errorMessage;

  PaymentResult({
    required this.success,
    this.transactionId,
    this.errorMessage,
  });

  @override
  String toString() {
    if (success) {
      return 'PaymentResult(success: true, transactionId: $transactionId)';
    } else {
      return 'PaymentResult(success: false, error: $errorMessage)';
    }
  }
}

/// Interface for payment processing
abstract class PaymentProcessor {
  /// Processes a payment for the given order
  Future<PaymentResult> processPayment(Order order, Map<String, dynamic> paymentDetails);

  /// Validates payment details before processing
  bool validatePaymentDetails(Map<String, dynamic> paymentDetails);

  /// Refunds a payment for the given transaction
  Future<PaymentResult> refundPayment(String transactionId, double amount);
}
