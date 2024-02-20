import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/controller/login_controller.dart';

class TextFieldPasswordLoginWidget extends GetView<LoginController> {
  const TextFieldPasswordLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        obscureText: true,
        obscuringCharacter: '*',
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        controller: controller.senhaInput,
        decoration: const InputDecoration(
          labelText: 'Senha',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          suffixIcon: Icon(PhosphorIcons.eye),
        ),
      ),
    );
  }
}
