import 'package:burger_shop/core/assets/assets.dart';
import 'package:flutter/material.dart';

class BurgerPage extends StatelessWidget {
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
                'Hoje, ${DateTime.now().day.toString()}/${DateTime.now().month.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //ListView.builder(itemBuilder: )
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: 0,
        //onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              label: 'Dashboard',
              icon: ImageIcon(AssetImage(Assets.dashboardIcon))),
          BottomNavigationBarItem(
              label: 'Cadastrar', icon: ImageIcon(AssetImage(Assets.pathPlus))),
          BottomNavigationBarItem(
              label: 'Simulador', icon: ImageIcon(AssetImage(Assets.discountIcon))),
        ],
      ),
    );
  }
}
