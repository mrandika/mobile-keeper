import 'package:flutter/material.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view/screen/item/item-add-screen.dart';
import 'package:keeper/view/screen/item/item-detail-screen.dart';
import 'package:keeper/view/screen/item/item-storage-screen.dart';
import 'package:keeper/view/screen/item/item-storage-update-screen.dart';

import '../view/screen/auth/login-screen.dart';
import '../view/home-container.dart';
import '../view/screen/item/item-update-screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routes) {
    switch (routes.name) {
      case AppRouters.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());
      case AppRouters.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeContainer());
      case AppRouters.addItem:
        return MaterialPageRoute(builder: (BuildContext context) => ItemAddScreen());
      case AppRouters.itemDetail:
        final id = routes.arguments as String;
        return MaterialPageRoute(builder: (BuildContext context) => ItemDetailScreen(id: id));
      case AppRouters.editItem:
        return MaterialPageRoute(builder: (BuildContext context) => ItemUpdateScreen());
      case AppRouters.itemStorages:
        return MaterialPageRoute(builder: (BuildContext context) => ItemStorageScreen());
      case AppRouters.editItemStorage:
        final index = routes.arguments as int;
        return MaterialPageRoute(builder: (BuildContext context) => ItemStorageUpdateScreen(index: index));
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
              body: Center(
                child: Text("No route defined"),
              ),
            )
        );
    }
  }
}