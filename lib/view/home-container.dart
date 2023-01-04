import 'package:flutter/material.dart';
import 'package:keeper/view/screen/account/account-screen.dart';
import 'package:keeper/view/screen/home/home-screen.dart';
import 'package:keeper/view/screen/item/item-screen.dart';
import 'package:keeper/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeScreen(),
    ItemScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final view_model = Provider.of<ProfileViewModel>(context, listen: false);

      if (view_model.user == null) {
        view_model.get_profile(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(177, 118, 60, 1),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromRGBO(209, 156, 102, 1),
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Item'
            ),

            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account'
            )
          ],
        ),
      ),
    );
  }
}

