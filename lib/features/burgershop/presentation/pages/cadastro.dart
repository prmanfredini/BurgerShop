import 'package:brasil_fields/brasil_fields.dart';
import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/cadastro_bloc.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/cadastro2.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

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
  var estados;
  var cidades;

  @override
  initState() {
    estados = CadastroBloc().buscaEstados();
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
                                    labelText: Strings.nome,
                                    labelStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                  validator: (value) {
                                    if (_nomeController.text.isEmpty) {
                                      return Strings.setNome;
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                  //   setState(() {});
                                  },
                                ),
                                TextFormField(
                                  controller: _cpfController,
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
                                    labelText: Strings.cpf,
                                    labelStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CpfInputFormatter(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (_cpfController.text.length < 14) {
                                      return Strings.setCPF;
                                    }
                                    return null;
                                  },
                                  // validator: (value) => Validator.cpf(value)
                                  //     ? Strings.setCPF
                                  //     : null,
                                  onChanged: (String value) {
                                  //   setState(() {});
                                  },
                                ),
                                DateTimePicker(
                                  controller: _dataController,
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
                                    labelText: Strings.nascimento,
                                    hintText: 'dd/mm/yyyy',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    labelStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2050),
                                  initialDate: DateTime.now(),
                                  fieldLabelText: Strings.nascimento,
                                  style: const TextStyle(color: Colors.white),
                                  type: DateTimePickerType.date,
                                  dateMask: 'dd/MM/yyyy',
                                  onChanged: (String value) {
                                    dataUnformatted = DateTime.parse(value);
                                    _dataController.text = value;
                                    //print(dataUnformatted);
                                    //setState(() {});
                                  },
                                  validator: (_) => _dataController.text.isEmpty
                                      ? Strings.setData
                                      : null,
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
                                      decoration: InputDecoration(
                                          prefixIconConstraints:
                                              const BoxConstraints
                                                  .tightForFinite(),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          labelText: Strings.estado,
                                          labelStyle: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey)),
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
                                        setState(() {
                                          cidades = CadastroBloc().buscaCidades(
                                              _estadoController.text);
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null) {
                                          return Strings.setState;
                                        }
                                        return null;
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
                                        decoration: InputDecoration(
                                            prefixIconConstraints:
                                                const BoxConstraints
                                                    .tightForFinite(),
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ),
                                            labelText: Strings.cidade,
                                            labelStyle: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey)),
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
                                          setState(() {});
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return Strings.setCity;
                                          }
                                          return null;
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              child: const Text(Strings.avancar),
                              onPressed: cadastroBloc.formCheck(_cadastroKey)
                                  ? () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Cadastro2(
                                                  _nomeController.text,
                                                  _cpfController.text,
                                                  dataUnformatted,
                                                  _estadoController.text,
                                                  _cidadeController.text)));
                                    }
                                  : null,
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
}
