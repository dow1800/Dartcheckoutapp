import 'package:dartcheckoutapp/dartcheckoutapp.dart';

/// Example usage of the Dart Checkout App
void main() async {
  print('=== Dart Checkout App Example ===\n');

  // Create a customer
  final customer = Customer(
    id: 'CUST_001',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+1234567890',
    address: Address(
      street: '123 Main St',
      city: 'San Francisco',
      state: 'CA',
      zipCode: '94102',
      country: 'USA',
    ),
  );

  print('Customer: ${customer.name} (${customer.email})');
  print('Address: ${customer.address}\n');

  // Create products
  final products = [
    Product(
      id: 'PROD_001',
      name: 'Laptop',
      price: 999.99,
      description: 'High-performance laptop',
    ),
    Product(
      id: 'PROD_002',
      name: 'Mouse',
      price: 29.99,
      description: 'Wireless mouse',
    ),
    Product(
      id: 'PROD_003',
      name: 'Keyboard',
      price: 79.99,
      description: 'Mechanical keyboard',
    ),
  ];

  // Create a cart and add products
  final cart = Cart();
  cart.addProduct(products[0], quantity: 1); // Laptop
  cart.addProduct(products[1], quantity: 2); // 2 Mice
  cart.addProduct(products[2], quantity: 1); // Keyboard

  print('Cart Summary:');
  for (var item in cart.items) {
    print('  - ${item.product.name} x${item.quantity}: \$${item.totalPrice.toStringAsFixed(2)}');
  }
  print('  Subtotal: \$${cart.subtotal.toStringAsFixed(2)}');
  print('  Tax (10%): \$${cart.tax.toStringAsFixed(2)}');
  print('  Total: \$${cart.total.toStringAsFixed(2)}\n');

  // Initialize checkout service with mock payment processor
  final paymentProcessor = MockPaymentProcessor();
  final checkoutService = CheckoutService(paymentProcessor: paymentProcessor);

  // Prepare payment details
  final paymentDetails = {
    'cardNumber': '4532123456789012',
    'expiryDate': '12/25',
    'cvv': '123',
    'cardholderName': 'John Doe',
  };

  // Process checkout
  print('Processing checkout...');
  final checkoutResult = await checkoutService.checkout(
    cart: cart,
    customer: customer,
    paymentMethod: PaymentMethod.creditCard,
    paymentDetails: paymentDetails,
  );

  if (checkoutResult.success) {
    final order = checkoutResult.order!;
    print('✓ Checkout successful!');
    print('Order ID: ${order.id}');
    print('Status: ${order.status.name}');
    print('Total: \$${order.cart.total.toStringAsFixed(2)}');
    print('Order created at: ${order.createdAt}');
  } else {
    print('✗ Checkout failed: ${checkoutResult.errorMessage}');
  }

  print('\n=== Example Complete ===');
}
