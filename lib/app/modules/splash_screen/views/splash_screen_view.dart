import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double height = 100.h;
    double width = 100.w;

    SplashScreenController controller = Get.put(SplashScreenController());

    return Scaffold(
      body: Center(
        child: Image.asset(
            height: height,
            width: width,
            ConstantsImage.splash_screen_image,
            fit: BoxFit.fill
        ),
      ),
    );
  }
}
