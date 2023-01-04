import 'package:flutter/material.dart';
import 'package:keeper/model/response/profile_response.dart';
import 'package:keeper/repository/auth_repository.dart';

import '../model/data/user.dart';

class ProfileViewModel with ChangeNotifier {
  final repo = AuthRepository();

  // State
  bool _is_loading = false;
  bool _is_error = false;
  User? _user;

  bool get is_loading => _is_loading;
  bool get is_error => _is_error;
  User? get user => _user;

  setLoading(bool state) {
    _is_loading = state;
    notifyListeners();
  }

  setError(bool state) {
    _is_error = state;
    notifyListeners();
  }

  setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> get_profile(BuildContext context) async {
    setLoading(true);
    setError(false);

    repo.get_profile().then((value) async {
      setLoading(false);

      // Saving the data
      setUser(ProfileResponse.fromJson(value).data);
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan'),
          )
      );
    });
  }
}