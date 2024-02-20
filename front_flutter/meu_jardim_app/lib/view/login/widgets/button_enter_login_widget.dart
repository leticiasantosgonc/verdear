import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/controller/login_controller.dart';

class ButtonEnterLoginWidget extends GetView<LoginController> {
  const ButtonEnterLoginWidget({super.key});

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
        controller.checkEmail();
      },
      child: Text(
        textAlign: TextAlign.start,
        'ENTRAR',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
