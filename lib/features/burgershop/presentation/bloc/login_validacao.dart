import 'package:burger_shop/features/burgershop/domain/entities/validacao_item.dart';
import 'package:flutter/material.dart';

class LoginValidation with ChangeNotifier {
  ValidationItem _user = ValidationItem(null, null);
  ValidationItem _pass = ValidationItem(null, null);

  ValidationItem get user => _user;
  ValidationItem get pass => _pass;

  bool get isValid {
    if (_user.value != null && _pass.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changeUser(String value) {
    if (value.length >= 3) {
      _user = ValidationItem(value, null);
    } else {
      _user = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void changePass(String value) {
    if (value.length >= 3) {
      _pass = ValidationItem(value, null);
    } else {
      _pass = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }


  void submitForm() {
    print(
        "username: ${user.value}, pass: ${pass.value}");
  }
}
