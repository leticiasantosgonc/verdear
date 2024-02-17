import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/screen/add_cultivo/widgets/cadastrar_cultivo_button_widget.dart';
import 'package:meu_jardim_app/screen/add_cultivo/widgets/especie_cultivo_widget.dart';
import 'package:meu_jardim_app/screen/add_cultivo/widgets/image_galeria_widget.dart';
import 'package:meu_jardim_app/screen/add_cultivo/widgets/local_cultivo_widget.dart';
import 'package:meu_jardim_app/screen/add_cultivo/widgets/luz_cultivo_widget.dart';
import 'package:meu_jardim_app/screen/add_cultivo/widgets/nome_cultivo_widget.dart';

import '../../widget/navegation_bar_widget.dart';
import 'widgets/comestivel_cultivo_widget.dart';
import 'widgets/descricao_cultivo_widget.dart';
import 'widgets/nome_botanico_cultivo_widget.dart';
import 'widgets/toxico_cultivo_widget.dart';

class AddPlantaScreen extends StatelessWidget {
  AddPlantaScreen({super.key});

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
      body: _body(),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(height: 125, child: ImageWidget()),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: Column(
                  children: [
                    NomeCultivoWidget(),
                    const SizedBox(height: 10),
                    NomeBotanicoCultivoWidget(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          DecricaoCultivoWidget(),
          const SizedBox(height: 10),
          EspecieCultivoWidget(),
          const SizedBox(height: 10),
          ComestivelCultivoWidget(),
          const SizedBox(height: 10),
          LocalCultivoWidget(),
          const SizedBox(height: 10),
          LuzCultivoWidget(),
          const SizedBox(height: 10),
          ToxicoCultivoWidget(),
          const SizedBox(height: 15),
          ButtonCadastrarCultivoWidget(),
        ],
      ),
    );
  }
}
