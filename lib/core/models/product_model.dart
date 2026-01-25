class Product {
  final String? id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;

  final DateTime createdAt;
  final DateTime updatedAt;
  final String slug;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      slug: json['slug'],
    );
  }
}
