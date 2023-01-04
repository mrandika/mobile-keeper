import 'package:flutter/material.dart';
import 'package:keeper/repository/auth_repository.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier {
  final repo = AuthRepository();

  // State
  bool _is_loading = false;
  bool get is_loading => _is_loading;

  setLoading(bool state) {
    _is_loading = state;
    notifyListeners();
  }

  Future<void> login(dynamic data, BuildContext context) async {
    setLoading(true);
    repo.login(data).then((value) async {
      setLoading(false);

      // Saving the data
      saveToken(value['data']['token'].toString());

      Navigator.pushReplacementNamed(context, AppRouters.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login gagal'),
          )
      );
    });
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('access_token', token);
    notifyListeners();
    return true;
  }
}