import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/more_menu_widget/assess_app_widget.dart';
import 'package:meu_jardim_app/view/more_menu_widget/account_creation_widget.dart';
import 'package:meu_jardim_app/view/more_menu_widget/information_app_widget.dart';
import 'package:meu_jardim_app/view/more_menu_widget/go_out_app_widget.dart';
import 'package:meu_jardim_app/view/more_menu_widget/version_app_widget.dart';

import 'more_menu_widget/delete_account_widget.dart';

class MoreView extends StatelessWidget {
  MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.background,
        surfaceTintColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 1,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.grey[200],
        title: Text(
          'Mais',
          style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
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
