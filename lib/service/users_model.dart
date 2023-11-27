import 'package:flutter/foundation.dart';

class UsersModel extends ChangeNotifier {
  String _token = '';
  String _userId = ''; // 현재 로그인한 사용자의 ID를 저장할 변수

  String get token => _token;
  String get userId => _userId; // 사용자 ID에 접근하기 위한 getter

  bool get isLoggedIn => _token.isNotEmpty;

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  // 사용자 ID를 설정하는 메서드
  void setUserId(String newUserId) {
    _userId = newUserId;
    notifyListeners();
  }
}
