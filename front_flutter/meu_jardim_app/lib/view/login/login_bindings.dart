import 'package:get/get.dart';
import 'package:meu_jardim_app/controller/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
