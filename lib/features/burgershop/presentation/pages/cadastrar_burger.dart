import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/data/models/burger_response.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/burger_list_bloc.dart';
import 'package:flutter/material.dart';

class CadastroBurger extends StatefulWidget {
  @override
  State<CadastroBurger> createState() => _CadastroBurgerState();
}

class _CadastroBurgerState extends State<CadastroBurger> {
  late List<BurgerResponse> _suggestions = [];
  late BurgerBloc burgerBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      burgerBloc = BurgerBloc(context);
    });
    //_suggestions.addAll(burgerBloc.buscaBurger());
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              Strings.seusBurgers,
              style:
              TextStyle(fontSize: 32, color: Colors.white),
            ),
            FutureBuilder<List<BurgerResponse>>(
              future: BurgerBloc(context).buscaBurger(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BurgerResponse>> snapshot) {
                if (snapshot.hasData) {
                  _suggestions = snapshot.data!;
                  return
                  Expanded(
                    child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Card(
                            color: Colors.black,
                            borderOnForeground: true,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  width:
                                  MediaQuery.of(context).size.width,
                                  height: 156,
                                  child: Image.network(_suggestions[index].cover),//Center(child: Text('imagem')),
                                ),
                                //Image.network(_suggestions[index].cover),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 12,
                                      left: 16,
                                      right: 16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.55,
                                            height: 30,
                                            child:
                                            SingleChildScrollView(
                                              scrollDirection:
                                              Axis.horizontal,
                                              child: Text(
                                                _suggestions[index]
                                                    .name,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    color:
                                                    Colors.white),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _suggestions[index]
                                                .price
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          SizedBox(
                                            width:
                                            MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.55,
                                            height: 20,
                                            child:
                                            SingleChildScrollView(
                                              scrollDirection:
                                              Axis.horizontal,
                                              child: Text(
                                                _suggestions[index]
                                                    .ingredients
                                                    .join(', '),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Colors.white),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _suggestions[index]
                                                .price
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(Assets.imagemErroInesperado),
                        const Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            Strings.erroInesperado,
                            style: TextStyle(
                                fontSize: 28, color: Colors.white),
                          ),
                        ),
                        const Text(Strings.erroHelp,
                            style: TextStyle(color: Colors.grey)),
                        TextButton(
                          onPressed: () {
                            print('carregar novamente');
                          },
                          child: Text(
                            Strings.carregar,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(Assets.ketchup),
                        const Padding(
                          padding: EdgeInsets.only(top: 24.0),
                          child: Text(
                            Strings.vazio,
                            style: TextStyle(
                                fontSize: 28, color: Colors.white),
                          ),
                        ),
                        const Text(Strings.vazioHelp,
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          print('add');
        },
      ),
    );
  }
}
