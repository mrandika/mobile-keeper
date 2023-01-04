import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:keeper/view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_input = TextEditingController();
  FocusNode email_focus = FocusNode();

  TextEditingController password_input = TextEditingController();
  FocusNode password_focus = FocusNode();

  String email = '';
  String password = '';

  @override
  void dispose() {
    super.dispose();
    email_input.dispose();
    email_focus.dispose();
    password_input.dispose();
    password_focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<LoginViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: Column(
            children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text.rich(
                      TextSpan(
                        text: 'Selamat datang di ',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Keeper', style: TextStyle(fontWeight: FontWeight.w900)),
                        ],
                      )
                  ),
                  const SizedBox(height: 8), // Padding
                  const Text(
                    "Untuk memulai, silahkan masuk menggunakan akun anda.",
                    style: TextStyle(
                        color: Colors.black38
                    ),
                  ),
                  const SizedBox(height: 32), // Padding
                  TextField(
                    controller: email_input,
                    focusNode: email_focus,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email'
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16), // Padding
                  TextField(
                    controller: password_input,
                    focusNode: password_focus,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password'
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!view_model.is_loading) {
                          Map data = {
                            'email': email_input.text,
                            'password': password_input.text
                          };

                          view_model.login(data, context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 40)
                      ),
                      child: view_model.is_loading ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ) : const Text('Masuk'),
                    ),
                  )
                ],
              )),
              const Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                    child: Text(
                      "Copyright © Keeper",
                      style: TextStyle(
                        color: Colors.black26
                      ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
