import 'package:dartcheckoutapp/dartcheckoutapp.dart';
import 'package:test/test.dart';

void main() {
  group('CheckoutService', () {
    late CheckoutService checkoutService;
    late MockPaymentProcessor paymentProcessor;
    late Cart cart;
    late Customer customer;

    setUp(() {
      paymentProcessor = MockPaymentProcessor();
      checkoutService = CheckoutService(paymentProcessor: paymentProcessor);
      cart = Cart();
      customer = Customer(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
      );
    });

    test('should fail checkout with empty cart', () async {
      final result = await checkoutService.checkout(
        cart: cart,
        customer: customer,
        paymentMethod: PaymentMethod.creditCard,
        paymentDetails: {},
      );

      expect(result.success, isFalse);
      expect(result.errorMessage, contains('empty'));
    });

    test('should successfully checkout with valid cart and payment', () async {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 50.0,
      );
      cart.addProduct(product);

      final result = await checkoutService.checkout(
        cart: cart,
        customer: customer,
        paymentMethod: PaymentMethod.creditCard,
        paymentDetails: {
          'cardNumber': '4532123456789012',
          'expiryDate': '12/25',
          'cvv': '123',
        },
      );

      expect(result.success, isTrue);
      expect(result.order, isNotNull);
      expect(result.order?.status, equals(OrderStatus.completed));
    });

    test('should clear cart after successful checkout', () async {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 50.0,
      );
      cart.addProduct(product);

      await checkoutService.checkout(
        cart: cart,
        customer: customer,
        paymentMethod: PaymentMethod.creditCard,
        paymentDetails: {
          'cardNumber': '4532123456789012',
          'expiryDate': '12/25',
          'cvv': '123',
        },
      );

      expect(cart.isEmpty, isTrue);
    });

    test('should fail checkout with invalid payment details', () async {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 50.0,
      );
      cart.addProduct(product);

      final result = await checkoutService.checkout(
        cart: cart,
        customer: customer,
        paymentMethod: PaymentMethod.creditCard,
        paymentDetails: {
          'cardNumber': '123', // Invalid card number
        },
      );

      expect(result.success, isFalse);
      expect(result.errorMessage, contains('Payment failed'));
    });

    test('should retrieve order by ID', () async {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 50.0,
      );
      cart.addProduct(product);

      final result = await checkoutService.checkout(
        cart: cart,
        customer: customer,
        paymentMethod: PaymentMethod.creditCard,
        paymentDetails: {
          'cardNumber': '4532123456789012',
          'expiryDate': '12/25',
          'cvv': '123',
        },
      );

      final order = checkoutService.getOrder(result.order!.id);
      expect(order, isNotNull);
      expect(order?.id, equals(result.order!.id));
    });

    test('should cancel pending order', () async {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 50.0,
      );
      cart.addProduct(product);

      final result = await checkoutService.checkout(
        cart: cart,
        customer: customer,
        paymentMethod: PaymentMethod.creditCard,
        paymentDetails: {
          'cardNumber': '4532123456789012',
          'expiryDate': '12/25',
          'cvv': '123',
        },
      );

      // This will fail because order is already completed
      final cancelled = checkoutService.cancelOrder(result.order!.id);
      expect(cancelled, isFalse);
    });
  });

  group('MockPaymentProcessor', () {
    late MockPaymentProcessor processor;

    setUp(() {
      processor = MockPaymentProcessor();
    });

    test('should validate valid payment details', () {
      final details = {
        'cardNumber': '4532123456789012',
        'expiryDate': '12/25',
        'cvv': '123',
      };

      expect(processor.validatePaymentDetails(details), isTrue);
    });

    test('should reject invalid card number', () {
      final details = {
        'cardNumber': '123',
        'expiryDate': '12/25',
        'cvv': '123',
      };

      expect(processor.validatePaymentDetails(details), isFalse);
    });

    test('should reject missing required fields', () {
      final details = {
        'cardNumber': '4532123456789012',
      };

      expect(processor.validatePaymentDetails(details), isFalse);
    });

    test('should process refund', () async {
      final result = await processor.refundPayment('TXN_123', 50.0);
      expect(result.success, isTrue);
      expect(result.transactionId, isNotNull);
    });
  });
}
