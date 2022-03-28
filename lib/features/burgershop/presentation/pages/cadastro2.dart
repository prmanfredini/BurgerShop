import 'package:brasil_fields/brasil_fields.dart';
import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/home.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/landing_page.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/loading.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Cadastro2 extends StatefulWidget {
  @override
  State<Cadastro2> createState() => _Cadastro2State();
}

class _Cadastro2State extends State<Cadastro2> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _pass2Controller = TextEditingController();
  final _authKey = GlobalKey<FormState>();

  //late bool showPass;
  bool loading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Assets.imagemLogoLettering,
          scale: 1.5,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            Strings.criarUser,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            Strings.etapa2,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Form(
                            key: _authKey,
                            child: Column(
                              children: [
                                TextFormField(
                                    controller: _userController,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
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
                                      prefixIconConstraints:
                                          const BoxConstraints.tightForFinite(),
                                      labelText: Strings.usuario,
                                      labelStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    validator: (value) {
                                      if (_userController.text.isEmpty) {
                                        return 'Digite seu nome';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {});
                                    }),
                                TextFormField(
                                    controller: _passController,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
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
                                      labelText: Strings.senha,
                                      labelStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    validator: (value) {
                                      if (_passController.text.length <= 3) {
                                        return 'Senha muito curta';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {});
                                    }),
                                TextFormField(
                                    controller: _pass2Controller,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
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
                                      labelText: Strings.confirmaSenha,
                                      labelStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    validator: (value) {
                                      if (_passController.text !=
                                          _pass2Controller.text) {
                                        return 'Senhas não coincidem';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {});
                                    }),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              child: loading
                                  ? TypingIndicator()
                                  : const Text(
                                      Strings.avancar,
                                      style: TextStyle(fontSize: 16),
                                    ),
                              onPressed: _validate(_userController.text,
                                  _passController.text, _pass2Controller.text),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white10;
                                    }
                                    return Theme.of(context)
                                        .colorScheme
                                        .secondary; // Use the component's default.
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _validate(String user, String senha, String confirma) {
    if (user.isNotEmpty && senha.isNotEmpty && confirma.isNotEmpty) {
      return () {
        setState(() {
          loading = true;
        });
        Future.delayed(const Duration(seconds: 1))
            .then((value) => setState(() {
                  loading = false;
                }))
            .whenComplete(() {
          if (_authKey.currentState!.validate()) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoadingPage()));
          }
        });
      };
    }
    return null;
  }
}
