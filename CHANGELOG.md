# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0] - 2025-11-02

### Added
- Initial release of Dart Checkout App
- Core domain models:
  - `Product`: Product catalog with pricing and details
  - `Cart`: Shopping cart with add/remove/update functionality
  - `CartItem`: Individual items in the cart
  - `Customer`: Customer information with address support
  - `Order`: Order management with status tracking
- Payment processing interface:
  - `PaymentProcessor`: Abstract interface for payment processing
  - `MockPaymentProcessor`: Example implementation for testing
- Services:
  - `CheckoutService`: Main service for processing orders and checkouts
- Comprehensive test suite:
  - Model tests for Cart, Product, Customer
  - Service tests for CheckoutService and PaymentProcessor
- Example application demonstrating usage
- Full documentation in README.md
- Analysis options for code quality
- .gitignore for Dart projects

### Features
- Shopping cart management with quantity updates
- Automatic tax calculation (10%)
- Order status tracking (pending, processing, completed, cancelled, refunded)
- Multiple payment method support
- Payment validation
- Order retrieval and cancellation
- Customer order history

## Project Structure

```
├── lib/
│   ├── dartcheckoutapp.dart       # Main library export
│   ├── models/                     # Domain models
│   │   ├── product.dart
│   │   ├── cart.dart
│   │   ├── cart_item.dart
│   │   ├── customer.dart
│   │   └── order.dart
│   ├── interfaces/                 # Service interfaces
│   │   └── payment_processor.dart
│   └── services/                   # Business logic
│       ├── checkout_service.dart
│       └── mock_payment_processor.dart
├── test/                           # Test suite
│   ├── models_test.dart
│   └── checkout_service_test.dart
├── example/                        # Example usage
│   └── main.dart
├── pubspec.yaml                    # Package configuration
├── analysis_options.yaml           # Linting rules
└── README.md                       # Documentation
```
