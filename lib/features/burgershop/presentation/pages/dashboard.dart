import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
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
    );
  }
}
