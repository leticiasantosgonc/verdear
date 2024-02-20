import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/add_farming_controller.dart';

class TextFieldTypeWidget extends GetView<AddFarmingController> {
  const TextFieldTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          hintText: 'Ex: Raiz, orquídea, suculenta...',
          labelText: 'Espécie',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
