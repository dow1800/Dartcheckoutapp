import '../interfaces/payment_processor.dart';
import '../models/order.dart';

/// Mock payment processor for demonstration purposes
class MockPaymentProcessor implements PaymentProcessor {
  @override
  Future<PaymentResult> processPayment(
    Order order,
    Map<String, dynamic> paymentDetails,
  ) async {
    // Simulate payment processing delay
    await Future.delayed(Duration(seconds: 1));

    // Validate payment details
    if (!validatePaymentDetails(paymentDetails)) {
      return PaymentResult(
        success: false,
        errorMessage: 'Invalid payment details',
      );
    }

    // Simulate successful payment
    final transactionId = 'TXN_${DateTime.now().millisecondsSinceEpoch}';
    return PaymentResult(
      success: true,
      transactionId: transactionId,
    );
  }

  @override
  bool validatePaymentDetails(Map<String, dynamic> paymentDetails) {
    // Basic validation - check if required fields are present
    if (paymentDetails['cardNumber'] == null ||
        paymentDetails['expiryDate'] == null ||
        paymentDetails['cvv'] == null) {
      return false;
    }

    // Simulate card number validation (must be 16 digits)
    final cardNumber = paymentDetails['cardNumber'].toString();
    if (cardNumber.length != 16 || !_isNumeric(cardNumber)) {
      return false;
    }

    return true;
  }

  @override
  Future<PaymentResult> refundPayment(String transactionId, double amount) async {
    // Simulate refund processing delay
    await Future.delayed(Duration(milliseconds: 500));

    // Simulate successful refund
    final refundId = 'REF_${DateTime.now().millisecondsSinceEpoch}';
    return PaymentResult(
      success: true,
      transactionId: refundId,
    );
  }

  bool _isNumeric(String str) {
    return int.tryParse(str) != null;
  }
}
