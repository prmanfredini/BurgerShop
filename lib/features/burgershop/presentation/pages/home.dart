import 'package:burger_shop/core/assets/assets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
              SizedBox(
                width: double.infinity,
                height: 160,
                child: Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            'X',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        'Aproveite!',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        'Dica do dia',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 25)
                    ],
                  ),
                ),
              ),
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
        items: [
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
