import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/register/widgets/textfield_name_register_widget.dart';

import 'widgets/textfield_email_register_widget.dart';
import 'widgets/button_register_widget.dart';
import 'widgets/textfield_password_register_widget.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criar conta',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: ListView(
        children: [
          const SizedBox(height: 15),
          const TextFieldNameRegisterWirdget(),
          const SizedBox(height: 15),
          const TextFieldEmailRegisterWidget(),
          const SizedBox(height: 15),
          const TextFieldPasswordRegisterWidget(),
          const SizedBox(height: 25),
          const ButtonRegisterWidget(),
        ],
      ),
    );
  }
}
