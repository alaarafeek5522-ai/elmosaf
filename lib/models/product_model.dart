class Product {
  final String id;
  final String name;
  final String price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'غير معروف',
      price: json['price']?.toString() ?? '0',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price)';
  }
}
