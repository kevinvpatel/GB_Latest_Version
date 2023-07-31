import 'package:get/get.dart';

import '../controllers/direct_message_screen_controller.dart';

class DirectMessageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DirectMessageScreenController>(
      () => DirectMessageScreenController(),
    );
  }
}
