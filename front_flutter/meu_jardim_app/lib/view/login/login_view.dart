import 'package:flutter/material.dart';
import 'package:meu_jardim_app/view/login/widgets/button_text_add_account_widget.dart';
import 'package:meu_jardim_app/view/login/widgets/textfield_email_login_widget.dart';
import 'package:meu_jardim_app/view/login/widgets/button_enter_login_widget.dart';
import 'package:meu_jardim_app/view/login/widgets/textfield_password_login_widget.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: ListView(
        children: [
          const SizedBox(height: 50),
          Image.asset(
            'lib/assets/logo_dark.png',
          ),
          const SizedBox(height: 50),
          const TextFieldEmailLoginWidget(),
          const SizedBox(height: 15),
          const TextFieldPasswordLoginWidget(),
          const SizedBox(height: 25),
          const ButtonEnterLoginWidget(),
          const SizedBox(height: 50),
          const Divider(),
          const ButtonTextAddAccountWidget(),
        ],
      ),
    );
  }
}
