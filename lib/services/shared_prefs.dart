// import 'dart:convert';

// import 'package:qn_2/models/product_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesUtil {
//   static const _cartKey = 'cart';

//   static Future<List<Product>> getCartItems() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = prefs.getString(_cartKey);
//     if (cartData == null) return [];
//     return List<Product>.from(
//         json.decode(cartData).map((item) => Product.fromJson(item)));
//   }

//   static Future<void> addToCart(Product product) async {
//     final cartItems = await getCartItems();
//     cartItems.add(product);
//     await saveCartItems(cartItems);
//   }

//   static Future<void> removeFromCart(int productId) async {
//     final cartItems = await getCartItems();
//     cartItems.removeWhere((item) => item.id == productId);
//     await saveCartItems(cartItems);
//   }

//   static Future<void> saveCartItems(List<Product> items) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_cartKey, json.encode(items));
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:qn_2/models/product_model.dart';

class SharedPreferencesUtil {
  static const String _cartKey = 'cart';

  static Future<void> addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList(_cartKey) ?? [];
    cart.add(jsonEncode(product.toJson())); // Convert Product to JSON string
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList(_cartKey) ?? [];
    cart.removeWhere((item) {
      final product = Product.fromJson(jsonDecode(item));
      return product.id == productId;
    });
    await prefs.setStringList(_cartKey, cart);
  }

  static Future<List<Product>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList(_cartKey) ?? [];
    return cart.map((item) => Product.fromJson(jsonDecode(item))).toList();
  }
}
