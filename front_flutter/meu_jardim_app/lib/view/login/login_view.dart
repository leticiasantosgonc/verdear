import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meu_jardim_app/view/login/login_widget.dart';

import '../../controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(),
    );
  }
}
