import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = 'https://ka8d596e67406a.user-app.krampoline.com/api';

  // 작품 상세페이지 조회
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


  // 카테고리별 작품 조회
  Future<Map<String, dynamic>> getCategoryProducts(String category, int page, int size, {String? sort}) async {
  var queryParams = {
    'type': category,
    'page': page.toString(),
    'size': size.toString(),
  };

  if (sort != null) {
    queryParams['sort'] = sort;
  }

  final uri = Uri.parse('$_baseUrl/products').replace(queryParameters: queryParams);
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };


    // 쿼리 파라미터를 URL에 포함합니다. (Uri 클래스 사용)
    final uri =
        Uri.parse('$_baseUrl/products').replace(queryParameters: queryParams);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    print('Requesting: $uri');
    final response = await http.get(uri, headers: headers);

    try {
      final response =
          await http.get(uri, headers: headers); // 여기에서 uri 변수를 사용합니다.

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

// 장바구니 전체 조회
  Future<Map<String, dynamic>> getCartDetails(int cartId) async {

    final String url = '$_baseUrl/carts/$cartId';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        return json.decode(decodedBody);
      } else {
        throw Exception('장바구니 정보를 불러오는 데 실패했습니다.');
      }
    } catch (error) {
      print('에러 발생: $error');
      rethrow;
    }
  }

  // 장바구니 상품 수량 증가
  Future<void> increaseCartItemQuantity(int cartId, int productId) async {
    final String url = '$_baseUrl/carts/$cartId/products/$productId/increase';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.patch(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        throw Exception('장바구니 상품 수량을 증가시키는 데 실패했습니다.');
      }
    } catch (error) {
      print('에러 발생: $error');
      rethrow;
    }
  }

// 장바구니 상품 수량 감소
  Future<void> decreaseCartItemQuantity(int cartId, int productId) async {
    final String url = '$_baseUrl/carts/$cartId/products/$productId/decrease';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.patch(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        throw Exception('장바구니 상품 수량을 감소시키는 데 실패했습니다.');
      }
    } catch (error) {
      print('에러 발생: $error');
      rethrow;
    }
  }
}


// 주문 생성
  Future<Map<String, dynamic>> createOrder({
    required String userId,
    required List<Map<String, dynamic>> orderDetails,
    required Map<String, dynamic> deliveryDetail,
  }) async {
    final String url = '$_baseUrl/orders';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // 주문 데이터를 JSON으로 인코딩
    final Map<String, dynamic> orderData = {
      'userId': userId,
      'orderDetails': orderDetails,
      'deliveryDetail': deliveryDetail,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(orderData),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        return json.decode(decodedBody);
      } else {
        throw Exception('주문 생성 실패');
      }
    } catch (error) {
      print('에러 발생: $error');
      rethrow;
    }
  }

  // 특정 유저 조회
  Future<Map<String, dynamic>> getUserDetails(String userId) async {
    final String url = '$_baseUrl/users/$userId';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        return json.decode(decodedBody);
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (error) {
      print('Error occurred: $error');
      rethrow;
    }
  }


}

