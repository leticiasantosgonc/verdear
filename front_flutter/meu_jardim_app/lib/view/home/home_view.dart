import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/widget/navegation_bar_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meu jardim',
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
        children: [],
      ),
    );
  }
}
