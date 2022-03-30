import 'dart:async';
import 'package:burger_shop/features/burgershop/presentation/bloc/login_bloc.dart';
import 'package:burger_shop/features/burgershop/data/models/login_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/dot_indicator.dart';
import 'package:provider/provider.dart';

import 'cadastro_dados.dart';
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

  bool hidePass = true;
  bool loading = false;
  LoginBloc loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validation = Provider.of<LoginValidation>(context);
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
                                      errorText: validation.user.error),
                                  onChanged: validation.changeUser,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  controller: _passController,
                                  obscureText: hidePass,
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
                                            hidePass
                                                ? Assets.showIcon
                                                : Assets.hiddenButtom,
                                            color: Colors.grey),
                                        onPressed: () {
                                          setState(() {
                                            hidePass = !hidePass;
                                          });
                                        },
                                      ),
                                      errorText: validation.pass.error),
                                  onChanged: validation.changePass,
                                ),
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
                              onPressed: validation.isValid
                                  ? () {
                                      setState(() {
                                        loading = true;
                                        Timer(const Duration(seconds: 1),
                                            () => loading = false);
                                      });
                                      loginBloc.validate(_userController.text,
                                          _passController.text, context, validation);
                                    }
                                  : null,
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
}
