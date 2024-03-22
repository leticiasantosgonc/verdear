import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/main.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text(
            'Nova senha',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            Image.asset(
              'lib/assets/no_plants.png',
            ),
            const SizedBox(height: 20),
            Text(
              textAlign: TextAlign.center,
              'Não se preocupe, vamos recuperar o seu acesso. Seus cultivos esperam por você!',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(15),
                minimumSize: Size(double.infinity, 0),
              ),
              onPressed: () async {
                String forgotEmail = emailController.text.trim();
                try {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(
                        email: forgotEmail,
                      )
                      .then((value) => sendEmail());
                  Get.to(RouteView());
                } on FirebaseAuthException catch (e) {
                  print('erro desconhecido $e');
                }
              },
              child: Text(
                'ENVIAR',
                textAlign: TextAlign.start,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }

  void sendEmail() {
    Get.snackbar('Redefinição de senha',
        'Email enviado com sucesso, olhe sua caixa de entrada!',
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
