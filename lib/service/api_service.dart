import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = 'http://64.110.89.251:8081/api';

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
  Future<Map<String, dynamic>> getCategoryProducts(String category, int page, int size, {String? sort}) async {
  var queryParams = {
    'type': category,
    'page': page.toString(),
    'size': size.toString(),
  };

  if (sort != null) {
    queryParams['sort'] = sort;
  }

  // 쿼리 파라미터를 URL에 포함합니다. (Uri 클래스 사용)
  final uri = Uri.parse('$_baseUrl/products').replace(queryParameters: queryParams);
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(uri, headers: headers); // 여기에서 uri 변수를 사용합니다.

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
