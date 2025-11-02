import 'package:dartcheckoutapp/dartcheckoutapp.dart';
import 'package:test/test.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    late Product product1;
    late Product product2;

    setUp(() {
      cart = Cart();
      product1 = Product(
        id: '1',
        name: 'Product 1',
        price: 10.0,
      );
      product2 = Product(
        id: '2',
        name: 'Product 2',
        price: 20.0,
      );
    });

    test('should be empty initially', () {
      expect(cart.isEmpty, isTrue);
      expect(cart.itemCount, equals(0));
      expect(cart.subtotal, equals(0));
    });

    test('should add product to cart', () {
      cart.addProduct(product1);
      expect(cart.isEmpty, isFalse);
      expect(cart.itemCount, equals(1));
      expect(cart.items.length, equals(1));
    });

    test('should increase quantity when adding same product', () {
      cart.addProduct(product1, quantity: 2);
      cart.addProduct(product1, quantity: 1);
      expect(cart.itemCount, equals(3));
      expect(cart.items.length, equals(1));
      expect(cart.items[0].quantity, equals(3));
    });

    test('should calculate subtotal correctly', () {
      cart.addProduct(product1, quantity: 2); // 2 * 10 = 20
      cart.addProduct(product2, quantity: 1); // 1 * 20 = 20
      expect(cart.subtotal, equals(40.0));
    });

    test('should calculate tax correctly', () {
      cart.addProduct(product1, quantity: 1); // 10
      expect(cart.tax, equals(1.0)); // 10% of 10
    });

    test('should calculate total correctly', () {
      cart.addProduct(product1, quantity: 1); // 10
      expect(cart.total, equals(11.0)); // 10 + 1 (tax)
    });

    test('should remove product from cart', () {
      cart.addProduct(product1);
      cart.addProduct(product2);
      cart.removeProduct('1');
      expect(cart.items.length, equals(1));
      expect(cart.items[0].product.id, equals('2'));
    });

    test('should update quantity', () {
      cart.addProduct(product1, quantity: 1);
      cart.updateQuantity('1', 5);
      expect(cart.items[0].quantity, equals(5));
    });

    test('should remove product when quantity is set to 0', () {
      cart.addProduct(product1);
      cart.updateQuantity('1', 0);
      expect(cart.isEmpty, isTrue);
    });

    test('should clear cart', () {
      cart.addProduct(product1);
      cart.addProduct(product2);
      cart.clear();
      expect(cart.isEmpty, isTrue);
      expect(cart.itemCount, equals(0));
    });
  });

  group('Product', () {
    test('should create product from JSON', () {
      final json = {
        'id': '1',
        'name': 'Test Product',
        'price': 99.99,
        'description': 'A test product',
      };

      final product = Product.fromJson(json);
      expect(product.id, equals('1'));
      expect(product.name, equals('Test Product'));
      expect(product.price, equals(99.99));
      expect(product.description, equals('A test product'));
    });

    test('should convert product to JSON', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 99.99,
      );

      final json = product.toJson();
      expect(json['id'], equals('1'));
      expect(json['name'], equals('Test Product'));
      expect(json['price'], equals(99.99));
    });
  });

  group('Customer', () {
    test('should create customer with address', () {
      final address = Address(
        street: '123 Main St',
        city: 'San Francisco',
        state: 'CA',
        zipCode: '94102',
        country: 'USA',
      );

      final customer = Customer(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        address: address,
      );

      expect(customer.name, equals('John Doe'));
      expect(customer.address?.city, equals('San Francisco'));
    });
  });
}
