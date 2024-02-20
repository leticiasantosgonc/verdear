import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/controller/login_controller.dart';
import 'package:meu_jardim_app/view/register/register_view.dart';

class LoginWidget extends GetView<LoginController> {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: ListView(
        children: [
          const SizedBox(height: 50),
          Image.asset(
            'lib/assets/logo_dark.png',
          ),
          const SizedBox(height: 50),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) => controller.validateEmail(),
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: controller.emailLoginInput,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) => controller.validatePassword(),
                  obscureText: true,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: controller.passwordLoginInput,
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
                const SizedBox(height: 25),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                    minimumSize: Size(double.infinity, 0),
                  ),
                  onPressed: () {
                    controller.login();
                  },
                  child: Text(
                    'ENTRAR',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Divider(),
          const SizedBox(height: 10),
          Row(
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
          )
        ],
      ),
    );
  }
}
