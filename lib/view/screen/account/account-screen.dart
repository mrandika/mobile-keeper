import 'package:flutter/material.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../component/error.dart';
import '../../component/loading.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<ProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, value, _) {
          if (value.is_loading) {
            return const LoadingComponent();
          } else if (value.is_error) {
            return const ErrorComponent();
          } else {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Image.asset('images/icn_profile.png', width: 120, height: 120),
                          SizedBox(height: 16),
                          Text(
                              '${view_model.user?.data?.firstName} ${view_model.user?.data?.lastName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Karyawan'),
                        ],
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                          child: Container(
                            width: double.infinity,
                            child: OutlinedButton(
                                onPressed: () => _dialogBuilder(context),
                                child: const Text(
                                  "Keluar",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                            ),
                          )
                      )
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final view_model = Provider.of<ProfileViewModel>(context, listen: false);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Keluar dari Akun?'),
          content: const Text('Pastikan semua pekerjaan anda sudah tersimpan sebelum melakukan logout.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Ya, Keluar',
                style: TextStyle(
                    color: Colors.red
                ),
              ),
              onPressed: () {
                view_model.logout(context);
              },
            ),
          ],
        );
      },
    );
  }
}