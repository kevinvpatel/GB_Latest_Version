import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:gb_latest_version/app/modules/home_screen/views/home_screen_view.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/onboarding_screen_controller.dart';

class OnboardingScreenView extends GetView<OnboardingScreenController> {
  const OnboardingScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double height = 100.h;
    double width = 100.w;

    return Scaffold(
      backgroundColor: ConstantsColor.themeColor,
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 3),
            Image.asset(ConstantsImage.onboarding_image, width: width * 0.75),
            Spacer(flex: 2,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 21.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.sp),
                border: Border.all(color: ConstantsColor.greenBorderColor)
              ),
              child: Column(
                children: [
                  Text('This content will educate you regarding all the \n'
                      'GB Version Tolls NEW Full Version and The best \n'
                      'approach to place in the GB What’s download.',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400, fontSize: 14.7.sp),
                  ),
                  SizedBox(height: 22.sp),
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.57,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.white12,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.sp))
                        ),
                        onPressed: () {
                          Get.to(HomeScreenView());
                        },
                        child: Image.asset(ConstantsImage.onboarding_button)
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button(
                    height: height,
                    width: width,
                    image: ConstantsImage.rating_button
                  ),
                  button(
                    height: height,
                    width: width,
                    image: ConstantsImage.share_button
                  ),
                  button(
                    height: height,
                    width: width,
                    image: ConstantsImage.policy_button
                  ),
                ],
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  button({required double height, required double width, required String image}) {
    return SizedBox(
      height: width * 0.255,
      width: width * 0.27,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.white12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.5.sp))
          ),
          onPressed: () {},
          child: Image.asset(image)
      ),
    );
  }

}
