import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meu_jardim_app/service/autentication_service.dart';

class AutenticationView extends StatelessWidget {
  AutenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutenticationWidget(),
    );
  }
}

class AutenticationWidget extends StatefulWidget {
  const AutenticationWidget({super.key});

  @override
  State<AutenticationWidget> createState() => _AutenticationWidgetState();
}

class _AutenticationWidgetState extends State<AutenticationWidget> {
  bool goSing = true;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController confirmPasswordInput = TextEditingController();

  AutenticationService _authService = AutenticationService();

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
            key: formKey,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (value) => validateEmail(),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: emailInput,
                    decoration: const InputDecoration(
                      fillColor: Colors.red,
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    validator: (value) => validatePassword(),
                    obscureText: true,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: passwordInput,
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
                ),
                if (!goSing) SizedBox(height: 15),
                Visibility(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: TextFormField(
                          validator: (value) => validateConfirmPassword(),
                          obscureText: true,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: confirmPasswordInput,
                          decoration: const InputDecoration(
                            labelText: 'Confirme a senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            suffixIcon: Icon(PhosphorIcons.eye),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        color: Colors.white,
                        child: TextFormField(
                          validator: (String? value) => validateName(),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          controller: nameInput,
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  visible: !goSing,
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
                    buttonGoHome();
                  },
                  child: Text(
                    (goSing) ? 'ENTRAR' : 'CADASTRAR',
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
                (goSing) ? 'Ainda não tem conta?' : "Já tem uma conta?",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    goSing = !goSing;
                  });
                },
                child: Text(
                  (goSing) ? 'Cadastre-se' : "Entrar",
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

  //controlador
  void buttonGoHome() {
    String name = nameInput.text.trim();
    String email = emailInput.text.trim();
    String password = passwordInput.text.trim();

    if (formKey.currentState!.validate()) {
      if (goSing) {
        _authService
            .login(
          email: email,
          password: password,
        )
            .then(
          (String? erro) {
            if (erro != null) {
              _showSnackErrorLogin(Get.context!);
            }
          },
        );
      } else {
        _authService
            .register(
          name: name,
          email: email,
          password: password,
        )
            .then(
          (String? erro) {
            if (erro != null) {
              _showSnackError(Get.context!);
            } else {
              _showSnackSucess(Get.context!);
            }
          },
        );
      }
    } else {
      print('Erro ao validar formulário');
    }
  }

  String? validateEmail() {
    String? value = emailInput.text.trim();

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
    String? value = passwordInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 5) {
      return 'Senha inválida, mínimo 5 caracteres';
    }
    return null;
  }

  String? validateName() {
    String? value = nameInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value.length < 5) {
      return 'Nome inválido';
    }
    return null;
  }

  String? validateConfirmPassword() {
    String? value = confirmPasswordInput.text.trim();

    if (value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value != passwordInput.text.trim()) {
      return 'Senhas não conferem';
    }

    return null;
  }

  void _showSnackSucess(BuildContext context) {
    Get.snackbar(
      'Bem vindo(a) ao meu jardim!',
      'Agora você pode acompanhar o crescimento dos seus cultivos. 🌱',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void _showSnackErrorLogin(BuildContext context) {
    Get.snackbar(
      'Não foi possível acessar o meu jardim 😢',
      'Email ou senha inválidos',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  void _showSnackError(BuildContext context) {
    Get.snackbar(
      'Não foi possível acessar o meu jardim 😢',
      'Email já cadastrado',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }
}
