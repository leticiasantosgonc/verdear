import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/screen/mais_menu/widgets/avalie_app_bottom_sheet.dart';
import 'package:meu_jardim_app/screen/mais_menu/widgets/data_criacao_conta_widget.dart';
import 'package:meu_jardim_app/screen/mais_menu/widgets/info_app_bottom_sheet.dart';
import 'package:meu_jardim_app/screen/mais_menu/widgets/sair_app_bottom_sheet.dart';
import 'package:meu_jardim_app/screen/mais_menu/widgets/versao_app_widget.dart';
import 'package:meu_jardim_app/widget/navegation_bar_widget.dart';

import 'widgets/excluir_conta_bottom_sheet.dart';

class MaisScreen extends StatelessWidget {
  MaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mais',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _body(),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.all(25),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Text(
            'Sua conta',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          SairAppWidget(),
          const SizedBox(height: 8),
          ExcluirContaAppWidget(),
          const SizedBox(height: 8),
          CriacaoContaWidget(),
          const SizedBox(height: 20),
          Text(
            'Menu',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          InfoAppWidget(),
          const SizedBox(height: 8),
          AvalieAppWidget(),
          const SizedBox(height: 8),
          VersaoAppWidget(),
        ],
      ),
    );
  }
}
