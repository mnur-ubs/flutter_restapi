class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final dynamic stock; // Some stock values are decimals in your example
  final String brand;
  final String category;
  final String thumbnail;
  final String images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        discountPercentage: (json['discountPercentage'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
        stock: json['stock'],
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: json['images'],
      );
}
