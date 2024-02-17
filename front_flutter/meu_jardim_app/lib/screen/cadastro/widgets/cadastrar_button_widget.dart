import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/cadastro_controller.dart';
import '../../home/home_screen.dart';

class ButtonCadastrarWidget extends GetView<CadastroController> {
  const ButtonCadastrarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(15),
      ),
      onPressed: () {
        Get.to(() => HomeScreen());
        _showToast();
      },
      child: Text(
          textAlign: TextAlign.start,
          'CADASTRAR',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
    );
  }
}

void _showToast() {
  Get.snackbar(
    'Bem vindo(a) ao meu jardim!',
    'Agora você pode acompanhar o crescimento das suas plantinhas. 🌱',
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
  );
}
