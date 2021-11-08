
import 'package:flutter/material.dart';


class LoginProvider with ChangeNotifier {

  bool _obscurePassword = true;
  bool _obscureKey = true;
  late String _username = "";
  late String _password = "";
  bool get obscureKey => _obscureKey;
  bool get obscurePassword => _obscurePassword;
  String get password => _password;
  String get username => _username;

  void toggleObscurePassword() {
    if(_obscurePassword == true) {
      _obscurePassword = false;
    } else {
      _obscurePassword = true;
    }
    notifyListeners();
  }

  void toggleObscureKey() {
    if(_obscureKey == true) {
      _obscureKey = false;
    } else {
      _obscureKey = true;
    }
    notifyListeners();
  }

  void setUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}