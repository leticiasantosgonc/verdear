import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/register_controller.dart';

class TextFieldNameRegisterWirdget extends GetView<CadastroController> {
  const TextFieldNameRegisterWirdget({super.key});

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
        ),
        decoration: const InputDecoration(
          labelText: 'Nome',
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
