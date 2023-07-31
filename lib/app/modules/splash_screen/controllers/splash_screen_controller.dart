import 'package:gb_latest_version/app/modules/onboarding_screen/views/onboarding_screen_view.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController


  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 1500), () {
      Get.to(OnboardingScreenView());
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
