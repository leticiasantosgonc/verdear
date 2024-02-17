import 'package:flutter/material.dart';
import 'package:meu_jardim_app/screen/login/widgets/cadastrar_text_widget.dart';
import 'package:meu_jardim_app/screen/login/widgets/email_field_widget.dart';
import 'package:meu_jardim_app/screen/login/widgets/entrar_button.dart';
import 'package:meu_jardim_app/screen/login/widgets/senha_field_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
            'lib/assets/logo_escuro.png',
          ),
          const SizedBox(height: 50),
          const EmailFieldLoginWidget(),
          const SizedBox(height: 15),
          const SenhaFiedlLoginWidget(),
          const SizedBox(height: 25),
          const ButtonEntrarLoginWidget(),
          const SizedBox(height: 50),
          const Divider(),
          const CadastrarTextLoginWidget(),
        ],
      ),
    );
  }
}
