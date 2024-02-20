import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/add_farming/widgets/button_add_farming_widget.dart';
import 'package:meu_jardim_app/view/add_farming/widgets/textfield_type_widget.dart';
import 'package:meu_jardim_app/view/add_farming/widgets/image_gallery_widget.dart';
import 'package:meu_jardim_app/view/add_farming/widgets/textfield_local_widget.dart';
import 'package:meu_jardim_app/view/add_farming/widgets/chip_light_widget.dart';
import 'package:meu_jardim_app/view/add_farming/widgets/textfield_name_add_farming_widget.dart';

import '../../widget/navegation_bar_widget.dart';
import 'widgets/comestible_widget.dart';
import 'widgets/textfield_description_widget.dart';
import 'widgets/textfield_botanical_name_widget.dart';
import 'widgets/chip_toxic_widget.dart';

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
                    TextFieldNameAddFarmingWidget(),
                    const SizedBox(height: 10),
                    TextFieldBotanicalNameWidget(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFieldDescriptionWidget(),
          const SizedBox(height: 10),
          TextFieldTypeWidget(),
          const SizedBox(height: 10),
          ComestibleWidget(),
          const SizedBox(height: 10),
          TextFieldLocalWidget(),
          const SizedBox(height: 10),
          ChipLightWidget(),
          const SizedBox(height: 10),
          ChipToxicWidget(),
          const SizedBox(height: 15),
          ButtonAddFarmingWidget(),
        ],
      ),
    );
  }
}
