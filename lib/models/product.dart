/// Represents a product in the checkout system
class Product {
  final String id;
  final String name;
  final double price;
  final String? description;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.imageUrl,
  });

  /// Creates a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// Converts this Product to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: \$$price)';
  }
}
