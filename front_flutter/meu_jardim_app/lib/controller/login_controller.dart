import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailLoginInput = TextEditingController();
  TextEditingController passwordLoginInput = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void login() {
    if (formKey.currentState!.validate()) {
      Get.toNamed('/home');
    }
  }

  String? validateEmail() {
    String? value = emailLoginInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 5) {
      return 'Email inválido';
    }
    if (!value.contains('@')) {
      return 'Email inválido';
    }
    return null;
  }

  String? validatePassword() {
    String? value = passwordLoginInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 5) {
      return 'Senha inválida, mínimo 5 caracteres';
    }
    return null;
  }
}
