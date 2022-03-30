import 'package:brasil_fields/brasil_fields.dart';
import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/cadastro_bloc.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/signup_validacao.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/cadastro_usuario.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/decoration_forms.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Cadastro extends StatefulWidget {
  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _cadastroKey = GlobalKey<FormState>();

  CadastroBloc cadastroBloc = CadastroBloc();
  DateTime dataUnformatted = DateTime.now();
  bool ignore = true;
  dynamic estados;
  dynamic cidades;

  @override
  initState() {
    estados = CadastroBloc().buscaEstados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validation = Provider.of<SignupValidation>(context);
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
                            Strings.cadastreSe,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            Strings.etapa1,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Form(
                            key: _cadastroKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nomeController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: inputDecorationForm(
                                      context, validation.name, Strings.nome),
                                  onChanged: validation.changeName,
                                ),
                                TextFormField(
                                  controller: _cpfController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: inputDecorationForm(
                                      context, validation.cpf, Strings.cpf),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CpfInputFormatter(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanged: validation.changeCpf,
                                ),
                                DateTimePicker(
                                  controller: _dataController,
                                  decoration: inputDecorationForm(context,
                                      validation.data, Strings.nascimento),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050),
                                  initialDate: DateTime.now(),
                                  fieldLabelText: Strings.nascimento,
                                  style: const TextStyle(color: Colors.white),
                                  type: DateTimePickerType.date,
                                  dateMask: 'dd/MM/yyyy',
                                  onChanged: (String value) {
                                    validation.changeData(value);
                                    dataUnformatted = DateTime.parse(value);
                                    _dataController.text = value;
                                  },
                                ),
                                FutureBuilder(
                                  future: estados,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    var resultado = ['Estados'];
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        resultado = ["Error"];
                                      } else {
                                        resultado = snapshot.data;
                                        if (resultado.isEmpty) {
                                          resultado = ["Algo deu errado."];
                                        }
                                      }
                                    }
                                    return DropdownButtonFormField(
                                      icon: const Icon(Icons.expand_more_sharp),
                                      iconEnabledColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      isExpanded: true,
                                      decoration: inputDecorationForm(context,
                                          validation.estado, Strings.estado),
                                      items: resultado.map((String e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        _estadoController.text =
                                            value.toString();
                                        validation
                                            .changeEstado(value.toString());
                                        setState(() {
                                          cidades = CadastroBloc().buscaCidades(
                                              _estadoController.text);
                                        });
                                      },
                                    );
                                  },
                                ),
                                FutureBuilder(
                                  future: cidades,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    var resultado = ['Cidades'];
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        resultado = ["Error"];
                                      } else {
                                        ignore = false;
                                        resultado = snapshot.data;
                                        if (resultado.isEmpty) {
                                          resultado = ["Algo deu errado."];
                                        }
                                      }
                                    }
                                    return IgnorePointer(
                                      ignoring: ignore,
                                      child: DropdownButtonFormField(
                                        icon:
                                            const Icon(Icons.expand_more_sharp),
                                        iconEnabledColor: ignore
                                            ? null
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                        isExpanded: true,
                                        decoration: inputDecorationForm(context,
                                            validation.cidade, Strings.cidade),
                                        items: resultado.map((String e) {
                                          return DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          _cidadeController.text =
                                              value.toString();
                                          validation
                                              .changeCidade(value.toString());
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            child: const Text(Strings.avancar),
                            onPressed: validation.isValid
                                ? () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CadastroUser(
                                              _nomeController.text,
                                              _cpfController.text,
                                              dataUnformatted,
                                              _estadoController.text,
                                              _cidadeController.text)));
                            }
                                : null,
                          ),
                        ),
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
