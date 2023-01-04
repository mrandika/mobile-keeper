import 'package:flutter/material.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view/screen/item/item-add-screen.dart';

import '../view/screen/auth/login-screen.dart';
import '../view/home-container.dart';

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