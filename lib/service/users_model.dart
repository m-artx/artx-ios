import 'package:flutter/foundation.dart';

class UsersModel extends ChangeNotifier {
  String _token = '';

  String get token => _token;

  bool get isLoggedIn => _token.isNotEmpty;

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }
}
