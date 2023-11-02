import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = 'http://123.108.166.72:8080/api';

  // 상품 상세 정보를 가져오는 메소드
  Future<Map<String, dynamic>> getProductDetails(String productId) async {
    final String url = '$_baseUrl/products/$productId'; // 수정된 URL
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> responseData = json.decode(decodedBody);
        return responseData;
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (error) {
      print('Error occurred: $error');
      rethrow;
    }
  }

  // 카테고리별 상품 목록을 가져오는 메소드
  Future<Map<String, dynamic>> getCategoryProducts(String category, int page, int size) async {
    final String url = '$_baseUrl/products?type=$category&page=$page&size=$size';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> responseData = json.decode(decodedBody);
        return responseData;
      } else {
        throw Exception('Failed to load category products');
      }
    } catch (error) {
      print('Error occurred: $error');
      rethrow;
    }
  }
}
