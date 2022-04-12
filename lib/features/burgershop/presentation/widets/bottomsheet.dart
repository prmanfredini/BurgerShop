import 'package:flutter/material.dart';

SizedBox bottomSheet(BuildContext context, String titulo, String contexto,
    String botao, String imagem, function) {
  return SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.54,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text(titulo, style: const TextStyle(fontSize: 24, color: Colors.white)),
          Text(contexto, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Image.asset(imagem),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              child: Text(botao, style: const TextStyle(fontSize: 16)),
              onPressed: function
            ),
          ),
        ],
      ),
    ),
  );
}
