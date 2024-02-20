import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/view/register/register_view.dart';

class ButtonTextAddAccountWidget extends StatelessWidget {
  const ButtonTextAddAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ainda não tem conta?',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          InkWell(
            onTap: () {
              Get.to(() => RegisterView());
            },
            child: Text(
              'Cadastrar',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
