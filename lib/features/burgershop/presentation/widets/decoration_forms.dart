import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/domain/entities/validacao_item.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecorationForm(BuildContext context, ValidationItem validation, String label) {
  return InputDecoration(
      prefixIconConstraints:
      const BoxConstraints.tightForFinite(),
      enabledBorder: const UnderlineInputBorder(
        borderSide:
        BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context)
                .colorScheme
                .secondary),
      ),
      labelText: label,
      labelStyle: const TextStyle(
          color: Colors.grey, fontSize: 20),
      errorText: validation.error);
}