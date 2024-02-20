import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameRegisterInput = TextEditingController();
  TextEditingController emailRegisterInput = TextEditingController();
  TextEditingController passwordRegisterInput = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void register() {
    if (formKey.currentState!.validate()) {
      Get.toNamed('/home');
      _showToast(Get.context!);
    }
  }

  String? validateEmail() {
    String? value = emailRegisterInput.text.trim();

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

  String? validateName() {
    String? value = nameRegisterInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 2) {
      return 'Nome inválido';
    }
    return null;
  }

  String? validatePassword() {
    String? value = passwordRegisterInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 5) {
      return 'Senha inválida, mínimo 5 caracteres';
    }
    return null;
  }

  void _showToast(BuildContext context) {
    Get.snackbar(
      'Bem vindo(a) ao meu jardim!',
      'Agora você pode acompanhar o crescimento dos seus cultivos. 🌱',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
