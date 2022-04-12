import 'package:burger_shop/core/assets/assets.dart';
import 'package:burger_shop/core/strings/strings.dart';
import 'package:flutter/material.dart';

Widget bottomBar(BuildContext context, TabController tabController) {
  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    color: Colors.black,
    child: TabBar(
      controller: tabController,
      indicatorColor: Theme.of(context).colorScheme.secondary,
      labelColor: Theme.of(context).colorScheme.secondary,
      unselectedLabelColor: Colors.white,
      enableFeedback: true,
      tabs: const [
        Tab(
          icon: ImageIcon(AssetImage(Assets.dashboardIcon)),
          child: Text(
              Strings.dashboard
          ),
        ),
        Tab(
            icon: ImageIcon(AssetImage(Assets.pathPlus)),
            child: Text(Strings.cadastrar)),
        Tab(
            icon: ImageIcon(AssetImage(Assets.discountIcon)),
            child: Text(Strings.simulador)),
      ],
    ),
  );
}