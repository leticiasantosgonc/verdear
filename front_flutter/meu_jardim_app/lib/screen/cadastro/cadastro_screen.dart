import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/screen/cadastro/widgets/nome_field_widget.dart';

import 'widgets/email_field_cadastro_widget.dart';
import 'widgets/cadastrar_button_widget.dart';
import 'widgets/senha_field_cadastro_widget.dart';

class CadastroScreen extends StatelessWidget {
  CadastroScreen({super.key});

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
          const NomeFieldCadastroWidget(),
          const SizedBox(height: 15),
          const EmailFieldCadastroWidget(),
          const SizedBox(height: 15),
          const SenhaFieldCadastroWidget(),
          const SizedBox(height: 25),
          const ButtonCadastrarWidget(),
        ],
      ),
    );
  }
}
