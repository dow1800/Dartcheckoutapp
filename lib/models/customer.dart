/// Represents a customer in the checkout system
class Customer {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final Address? address;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
  });

  /// Creates a Customer from a JSON map
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this Customer to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address?.toJson(),
    };
  }

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, email: $email)';
  }
}

/// Represents a customer address
class Address {
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  /// Creates an Address from a JSON map
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
    );
  }

  /// Converts this Address to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
    };
  }

  @override
  String toString() {
    return '$street, $city, $state $zipCode, $country';
  }
}
