// class Product {
//   final int id;
//   final String title;
//   final double price;
//   final String thumbnail;

//   Product({required this.id, required this.title, required this.price, required this.thumbnail});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       title: json['title'],
//       price: json['price'].toDouble(),
//       thumbnail: json['thumbnail'],
//     );
//   }
// }
class Product {
  final int id;
  final String title;
  final String thumbnail;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
    };
  }
}
