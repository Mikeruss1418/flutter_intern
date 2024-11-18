import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qn_2/models/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['products'];
      return List<Product>.from(data.map((item) => Product.fromJson(item)));
    } else {
      throw Exception("Failed to load products");
    }
  }
}
