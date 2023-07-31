import 'package:get/get.dart';

import '../controllers/whats_cleaner_screen_controller.dart';

class WhatsCleanerScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhatsCleanerScreenController>(
      () => WhatsCleanerScreenController(),
    );
  }
}
