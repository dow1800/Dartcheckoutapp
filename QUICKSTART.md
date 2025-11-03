# Quick Start Guide

This guide will help you get started with the Dart Checkout App quickly.

## Prerequisites

- Dart SDK 2.17.0 or higher

## Installation

1. Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dartcheckoutapp:
    git:
      url: https://github.com/dow1800/Dartcheckoutapp.git
```

2. Install dependencies:

```bash
dart pub get
```

## Basic Usage

### 1. Create a Customer

```dart
import 'package:dartcheckoutapp/dartcheckoutapp.dart';

final customer = Customer(
  id: 'CUST_001',
  name: 'John Doe',
  email: 'john@example.com',
  phone: '+1234567890',
);
```

### 2. Create Products

```dart
final laptop = Product(
  id: 'PROD_001',
  name: 'Laptop',
  price: 999.99,
  description: 'High-performance laptop',
);

final mouse = Product(
  id: 'PROD_002',
  name: 'Wireless Mouse',
  price: 29.99,
);
```

### 3. Add Products to Cart

```dart
final cart = Cart();
cart.addProduct(laptop, quantity: 1);
cart.addProduct(mouse, quantity: 2);

// Check cart totals
print('Subtotal: \$${cart.subtotal}');
print('Tax: \$${cart.tax}');
print('Total: \$${cart.total}');
```

### 4. Process Checkout

```dart
// Initialize checkout service
final paymentProcessor = MockPaymentProcessor();
final checkoutService = CheckoutService(
  paymentProcessor: paymentProcessor,
);

// Process payment
final result = await checkoutService.checkout(
  cart: cart,
  customer: customer,
  paymentMethod: PaymentMethod.creditCard,
  paymentDetails: {
    'cardNumber': '4532123456789012',
    'expiryDate': '12/25',
    'cvv': '123',
    'cardholderName': 'John Doe',
  },
);

// Check result
if (result.success) {
  print('Order successful! ID: ${result.order?.id}');
} else {
  print('Checkout failed: ${result.errorMessage}');
}
```

### 5. Manage Orders

```dart
// Get order by ID
final order = checkoutService.getOrder(orderId);

// Get all orders for a customer
final customerOrders = checkoutService.getOrdersByCustomer('CUST_001');

// Cancel an order (only if not completed)
final cancelled = checkoutService.cancelOrder(orderId);
```

## Cart Operations

### Add Products
```dart
cart.addProduct(product, quantity: 2);
```

### Update Quantity
```dart
cart.updateQuantity(productId, 5);
```

### Remove Product
```dart
cart.removeProduct(productId);
```

### Clear Cart
```dart
cart.clear();
```

## Payment Methods

Available payment methods:
- `PaymentMethod.creditCard`
- `PaymentMethod.debitCard`
- `PaymentMethod.paypal`
- `PaymentMethod.applePay`
- `PaymentMethod.googlePay`
- `PaymentMethod.cash`

## Order Status

Orders can have the following statuses:
- `OrderStatus.pending` - Order created but not yet processed
- `OrderStatus.processing` - Payment is being processed
- `OrderStatus.completed` - Order successfully completed
- `OrderStatus.cancelled` - Order cancelled
- `OrderStatus.refunded` - Order refunded

## Running the Example

To see a complete working example:

```bash
dart run example/main.dart
```

## Running Tests

```bash
dart test
```

## Next Steps

- Implement a custom `PaymentProcessor` for your payment gateway
- Extend the models with additional fields as needed
- Add discount/coupon functionality
- Implement shipping calculations
- Add inventory management

## Need Help?

Check out the full [README.md](README.md) for more detailed documentation.
