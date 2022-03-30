import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/cadastro_bloc.dart';
import 'package:burger_shop/features/burgershop/data/models/user_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/decoration_forms.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CadastroUser extends StatefulWidget {
  final String nome;
  final String cpf;
  final DateTime data;
  final String estado;
  final String cidade;

  const CadastroUser(this.nome, this.cpf, this.data, this.estado, this.cidade,
      {Key? key})
      : super(key: key);

  @override
  State<CadastroUser> createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _pass2Controller = TextEditingController();
  final _authKey = GlobalKey<FormState>();

  final CadastroBloc cadastroBloc = CadastroBloc();
  bool loading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validation = Provider.of<UserValidation>(context);
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
                                  decoration: inputDecorationForm(context,
                                      validation.user, Strings.usuario),
                                  onChanged: validation.changeUser,
                                ),
                                TextFormField(
                                  controller: _passController,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: inputDecorationForm(
                                      context, validation.pass, Strings.senha),
                                  onChanged: validation.changePass,
                                ),
                                TextFormField(
                                  controller: _pass2Controller,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: inputDecorationForm(context,
                                      validation.pass2, Strings.confirmaSenha),
                                  onChanged: validation.changePass2,
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
                                  ? TypingIndicator()
                                  : const Text(
                                      Strings.avancar,
                                      style: TextStyle(fontSize: 16),
                                    ),
                              onPressed: validation.isValid
                                  ? () {
                                      setState(() {
                                        loading = true;
                                      });
                                      cadastroBloc.validate(
                                          widget.nome,
                                          _userController.text,
                                          widget.cpf,
                                          widget.data,
                                          widget.estado,
                                          widget.cidade,
                                          _passController.text,
                                          context);
                                    }
                                  : null,
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
}
