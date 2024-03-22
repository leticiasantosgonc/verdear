import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/more_menu/widgets/assess_app_widget.dart';
import 'package:meu_jardim_app/view/more_menu/widgets/account_creation_widget.dart';
import 'package:meu_jardim_app/view/more_menu/widgets/information_app_widget.dart';
import 'package:meu_jardim_app/view/more_menu/widgets/go_out_app_widget.dart';
import 'package:meu_jardim_app/view/more_menu/widgets/version_app_widget.dart';

import 'widgets/delete_account_widget.dart';

class MoreView extends StatelessWidget {
  MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(
          'Mais',
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
          const SizedBox(height: 10),
          Text(
            'Sua conta',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          GoOutAppWidget(),
          const SizedBox(height: 8),
          DeleteAccountWidget(),
          const SizedBox(height: 8),
          AccountCreationWidget(),
          const SizedBox(height: 20),
          Text(
            'Menu',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          InformationAppWidget(),
          const SizedBox(height: 8),
          AssessAppWidget(),
          const SizedBox(height: 8),
          VersionAppWidget(),
        ],
      ),
    );
  }
}
