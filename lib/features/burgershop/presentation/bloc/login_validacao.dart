import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/domain/entities/validacao_item.dart';
import 'package:flutter/material.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

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
    if (!Validator.email(value)) {
      _user = ValidationItem(value, null);
    } else {
      _user = ValidationItem(null, Strings.setEmail);
    }
    notifyListeners();
  }

  void changePass(String value) {
    if (value.length >= 3) {
      _pass = ValidationItem(value, null);
    } else {
      _pass = ValidationItem(null, Strings.shortPass);
    }
    notifyListeners();
  }

  void wrongPass() {
    _user = ValidationItem(null, '');
    _pass = ValidationItem(null, Strings.wrongLogin);
    notifyListeners();
  }

  void submitForm() {
    //return true;
    print("username: ${user.value}, pass: ${pass.value}");
  }
}
