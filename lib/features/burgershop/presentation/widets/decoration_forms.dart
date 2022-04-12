import 'package:burger_shop/features/burgershop/domain/entities/validacao_item.dart';
import 'package:flutter/material.dart';

InputDecoration inputDecorationForm(BuildContext context,
    ValidationItem validation, String label, TextEditingController controller,
    {String icon = ''}) {
  return InputDecoration(
      prefixIconConstraints: const BoxConstraints.tightForFinite(),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
      errorText: validation.error,
      prefixIcon: icon == ''
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                icon,
                color: controller.text.isEmpty
                    ? Colors.grey
                    : Theme.of(context).colorScheme.secondary,
              ),
            ));
}
