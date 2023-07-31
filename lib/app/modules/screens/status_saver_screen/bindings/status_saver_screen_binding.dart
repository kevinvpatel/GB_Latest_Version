import 'package:get/get.dart';

import '../controllers/status_saver_screen_controller.dart';

class StatusSaverScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusSaverScreenController>(
      () => StatusSaverScreenController(),
    );
  }
}
