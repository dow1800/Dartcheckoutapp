# Dart Checkout App

A recommended Dart checkout application with cart management and payment processing functionality.

## Features

- **Cart Management**: Add, remove, and update products in a shopping cart
- **Product Catalog**: Manage products with details like name, price, description, and images
- **Customer Management**: Handle customer information including addresses
- **Order Processing**: Create and manage orders with multiple statuses
- **Payment Processing**: Flexible payment processing interface with mock implementation
- **Tax Calculation**: Automatic tax calculation (configurable)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dartcheckoutapp:
    git:
      url: https://github.com/dow1800/Dartcheckoutapp.git
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Example

```dart
import 'package:dartcheckoutapp/dartcheckoutapp.dart';

void main() async {
  // Create a customer
  final customer = Customer(
    id: 'CUST_001',
    name: 'John Doe',
    email: 'john.doe@example.com',
  );

  // Create a cart and add products
  final cart = Cart();
  final product = Product(
    id: 'PROD_001',
    name: 'Laptop',
    price: 999.99,
  );
  cart.addProduct(product, quantity: 1);

  // Initialize checkout service
  final paymentProcessor = MockPaymentProcessor();
  final checkoutService = CheckoutService(paymentProcessor: paymentProcessor);

  // Process checkout
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

  if (result.success) {
    print('Order ID: ${result.order?.id}');
  }
}
```

## Core Components

### Models

- **Product**: Represents a product with id, name, price, and optional details
- **Cart**: Shopping cart that manages cart items and calculates totals
- **CartItem**: Individual item in the cart with product and quantity
- **Customer**: Customer information including address
- **Order**: Represents an order with status tracking

### Services

- **CheckoutService**: Main service for processing checkouts and managing orders
- **MockPaymentProcessor**: Example payment processor implementation

### Interfaces

- **PaymentProcessor**: Interface for implementing custom payment processors

## Running the Example

To run the included example:

```bash
dart run example/main.dart
```

## Development

### Running Tests

```bash
dart test
```

### Linting

```bash
dart analyze
```

## Architecture

The application follows a clean architecture approach with:

- **Models**: Domain entities and data structures
- **Interfaces**: Contracts for services
- **Services**: Business logic and operations

## Payment Processing

The library includes a `PaymentProcessor` interface that can be implemented for various payment gateways:

```dart
abstract class PaymentProcessor {
  Future<PaymentResult> processPayment(Order order, Map<String, dynamic> paymentDetails);
  bool validatePaymentDetails(Map<String, dynamic> paymentDetails);
  Future<PaymentResult> refundPayment(String transactionId, double amount);
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
