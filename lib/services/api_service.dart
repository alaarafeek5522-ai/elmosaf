import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:elmosaf/models/product_model.dart';

class ApiService {
  static const String baseUrl = 'http://moelshafey.top/API/MD/search.php';

  static Future<List<Product>> searchMedicine(String query) async {
    try {
      final encodedQuery = Uri.encodeQueryComponent(query);
      final uri = Uri.parse('$baseUrl?name=$encodedQuery');
      
      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'Dart/3.7 (dart:io)',
          'Accept-Encoding': 'gzip',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['code'] == 200 && data['error'] == false) {
          final List productsJson = data['products'] ?? [];
          return productsJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception(data['message'] ?? 'حدث خطأ في البحث');
        }
      } else {
        throw Exception('فشل الاتصال بالخادم (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('خطأ: ${e.toString()}');
    }
  }
}
