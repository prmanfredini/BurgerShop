import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/domain/entities/validacao_item.dart';
import 'package:flutter/material.dart';

class SignupValidation with ChangeNotifier {
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _cpf = ValidationItem(null, null);
  ValidationItem _data = ValidationItem(null, null);
  ValidationItem _estado = ValidationItem(null, null);
  ValidationItem _cidade = ValidationItem(null, null);

  ValidationItem get name => _name;
  ValidationItem get cpf => _cpf;
  ValidationItem get data => _data;
  ValidationItem get estado => _estado;
  ValidationItem get cidade => _cidade;

  bool get isValid {
    if (_cpf.value != null &&
        _name.value != null &&
        _data.value != null &&
        _estado.value != null &&
        _cidade.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void changeName(String value) {
    if (value.length >= 3) {
      _name = ValidationItem(value, null);
    } else {
      _name = ValidationItem(null, Strings.setNome);
    }
    notifyListeners();
  }

  void changeCpf(String value) {
    if (value.length == 14) {
      _cpf = ValidationItem(value, null);
    } else {
      _cpf = ValidationItem(null, Strings.setCPF);
    }
    notifyListeners();
  }

  void changeData(String value) {
    try {
      DateTime.parse(value);
      _data = ValidationItem(value, null);
    } catch (error) {
      _data = ValidationItem(null, Strings.setData);
    }
    notifyListeners();
  }

  void changeEstado(String value) {
    if (value.isNotEmpty) {
      _estado = ValidationItem(value, null);
    } else {
      _estado = ValidationItem(null, Strings.setState);
    }
    notifyListeners();
  }
  void changeCidade(String value) {
    if (value.isNotEmpty) {
      _cidade = ValidationItem(value, null);
    } else {
      _cidade = ValidationItem(null, Strings.setCity);
    }
    notifyListeners();
  }

  void submitForm() {
    print(
        "name: ${name.value}, cpf: ${cpf.value}, ${DateTime.parse(data.value!)}");
  }
}
