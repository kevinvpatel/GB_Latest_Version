import 'package:get/get.dart';

import '../controllers/whats_web_screen_controller.dart';

class WhatsWebScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhatsWebScreenController>(
      () => WhatsWebScreenController(),
    );
  }
}
