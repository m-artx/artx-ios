import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> testApi() async {
  final String url = 'http://123.108.166.72:8080/api/users/35a69652-6a41-4372-9f1b-0b32215e8af7/products';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    // 응답 코드와 본문을 출력
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');  // 추가된 부분

    final Map<String, dynamic> responseData = json.decode(response.body);
    // ... responseData를 사용하여 추가 처리 ...

  } catch (error) {
    print('Error occurred: $error');
  }
}
