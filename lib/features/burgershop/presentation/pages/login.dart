import 'dart:io';

import 'package:burger_shop/features/burgershop/data/datasources/login.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/loading.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/dot_indicator.dart';

import 'cadastro.dart';
import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  late bool showPass;
  bool loading = false;

  @override
  void initState() {
    showPass = true;
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
                            Strings.efetueLogin,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                          const Text(
                            Strings.loginHelp,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Form(
                            key: _loginKey,
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
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Image.asset(
                                          Assets.profileIcon,
                                          color: _userController.text.isEmpty
                                              ? Colors.grey
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                        ),
                                      ),
                                      labelText: Strings.usuario,
                                      labelStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    validator: (value) {
                                      if (_passController.text.length < 3) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      setState(() {});
                                    }),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                    controller: _passController,
                                    obscureText: showPass,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      prefixIconConstraints:
                                          const BoxConstraints.tightForFinite(),
                                      prefixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Image.asset(
                                          Assets.passwordIcon,
                                          color: _passController.text.isEmpty
                                              ? Colors.grey
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                        ),
                                      ),
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
                                          color: Colors.grey, fontSize: 16),
                                      suffixIcon: IconButton(
                                        icon: Image.asset(
                                            showPass
                                                ? Assets.showIcon
                                                : Assets.hiddenButtom,
                                            color: Colors.grey),
                                        onPressed: () {
                                          setState(() {
                                            showPass = !showPass;
                                          });
                                        },
                                      ),
                                    ),
                                    validator: (value) {
                                      if (_passController.text.length < 3) {
                                        return Strings.wrongLogin;
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
                                  ? const TypingIndicator()
                                  : const Text(
                                      Strings.entrar,
                                      style: TextStyle(fontSize: 16),
                                    ),
                              onPressed: _validate(
                                  _userController.text, _passController.text),
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
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(Strings.novaConta,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                          TextButton(
                              child: const Text(
                                Strings.cadastreSe,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Cadastro()));
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _validate(String user, String senha) {
    if (user.isNotEmpty && senha.isNotEmpty) {
      return () async {
        setState(() {
          loading = true;
        });
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
            Future.delayed(const Duration(seconds: 2))
                .then((value) => setState(() {
                      loading = false;
                    }))
                .whenComplete(() {
              if (_loginKey.currentState!.validate()) {
                WebLogin().doLogin(user,senha).then((value) => print(value.user.fullname));
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoadingPage()));
              }
            });
          }
        } on SocketException catch (_) {
          print('not connected');
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          Strings.conectadoCheck,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          Strings.conectadoHelp,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Image.asset(Assets.imagemConnectionFail),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.secondary),
                            ),
                            child: Text(
                              'Tenta novamente',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        } on Error catch (_) {
          print('Erro inesperado');
          showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Text(
                          Strings.erroInesperado,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          Strings.erroHelp,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Image.asset(Assets.imagemErroInesperado),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.secondary),
                            ),
                            child: Text(
                              'Ok',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      };
    }
    return null;
  }
}
