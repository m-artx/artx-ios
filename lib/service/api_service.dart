import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'users_model.dart';

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
    'category': category, // 'type' 대신 'category' 사용
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

  print('Requesting: $uri');
  try {
    final response = await http.get(uri, headers: headers);

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
Future<Map<String, dynamic>> getCartDetails(String token) async {
        final String url = '$_baseUrl/cart';
        final Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
        };

        try {
            final response = await http.get(Uri.parse(url), headers: headers);

            if (response.statusCode == 200) {
                final decodedBody = utf8.decode(response.bodyBytes);
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


  // 로그인 api
  Future<Map<String, dynamic>> login(String username, String password) async {
    final String url = '$_baseUrl/auth/login';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('로그인 실패');
      }
    } catch (error) {
      print('로그인 에러: $error');
      rethrow;
    }
  }

  // 로그아웃 api
  Future<void> logout() async {
    final String url = '$_baseUrl/auth/logout';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode != 200) {
        throw Exception('로그아웃 실패');
      }
    } catch (error) {
      print('로그아웃 에러: $error');
      rethrow;
    }
  }


// 마이페이지 조회 api
Future<Map<String, dynamic>> getMyPageInfo(BuildContext context) async {
  final String url = '$_baseUrl/mypage';
  final token = Provider.of<UsersModel>(context, listen: false).token;

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      return json.decode(decodedBody);
    } else {
      throw Exception('Failed to load my page info');
    }
  } catch (error) {
    print('Error occurred: $error');
    rethrow;
  }
}
}

