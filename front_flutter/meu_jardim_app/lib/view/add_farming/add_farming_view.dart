import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/add_farming/add_farming_widget.dart';

import '../../widget/navegation_bar_widget.dart';

class AddFarmingView extends StatelessWidget {
  AddFarmingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: AddFarmingWidget(),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
