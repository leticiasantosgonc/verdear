import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailInput = TextEditingController();
  TextEditingController senhaInput = TextEditingController();

  static const email = 'let@email.com';
  static const senha = 'nix';

  void checkEmail() {
    switch (emailInput.text) {
      case email:
        checkSenha();
        break;

      case '':
        error('Insira um e-mail válido');
        break;
      default:
        error('E-mail não cadastrado');
    }
  }

  void checkSenha() {
    switch (senhaInput.text) {
      case senha:
        login();
        break;

      case '':
        error('Insira uma senha válida');
        break;
      default:
        print('Senha incorreta');
    }
  }

  void login() {
    Get.toNamed('/home');
  }

  void error(String e) {
    print(e);
  }
}
