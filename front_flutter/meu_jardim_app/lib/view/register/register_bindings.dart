import 'package:get/get.dart';

import '../../controller/register_controller.dart';

class CadastroBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CadastroController());
  }
}
