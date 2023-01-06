import 'package:flutter/material.dart';
import 'package:keeper/view_model/item-detail_view_model.dart';
import 'package:keeper/view_model/item_view_model.dart';
import 'package:keeper/view_model/login_view_model.dart';
import 'package:keeper/view_model/profile_view_model.dart';
import 'package:keeper/view_model/location_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/utils/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keeper/resources/api_token.dart' as globals;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  globals.token = prefs.getString("access_token") ?? '';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => ItemViewModel()),
        ChangeNotifierProvider(create: (_) => ItemDetailViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.brown,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Color.fromRGBO(177, 118, 60, 1),
            elevation: 0,
            centerTitle: false
          ),
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )
        ),
        initialRoute: globals.token == '' ? AppRouters.login : AppRouters.home,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
