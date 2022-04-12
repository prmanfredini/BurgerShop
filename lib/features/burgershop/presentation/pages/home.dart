import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:burger_shop/features/burgershop/presentation/bloc/cadastro_bloc.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/cadastrar_burger.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/dashboard.dart';
import 'package:burger_shop/features/burgershop/presentation/pages/simulador.dart';
import 'package:burger_shop/features/burgershop/presentation/widets/bottombar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
          }
        });
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(Assets.userImage),
        ),
        title: const Text(
          'Olá, @usuário',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '${Strings.hoje}, ${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0,left: 16,right: 16),
          child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Dashboard(),
            RefreshIndicator(
               backgroundColor: Colors.grey[200],
               color: Theme.of(context).colorScheme.secondary,
              strokeWidth: 3,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 1500));
                  print('teste');
//                setState(() { });
              },
              child: CadastroBurger(),
            ),

            Simulador(),
          ]),
        ),
      ),
        bottomNavigationBar: bottomBar(context, tabController),
    );
  }
}

