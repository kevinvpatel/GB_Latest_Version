import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectMessageScreenController extends GetxController {
  //TODO: Implement ScreensDirectMessageScreenController


  RxString countryDialCode = '+91'.obs;

  Rx<TextEditingController> txtPhoneNumber = TextEditingController().obs;
  Rx<TextEditingController> txtMessage = TextEditingController().obs;
  RxBool isPhoneNumberEnable = false.obs;
  RxBool isMessageEnable = false.obs;



  @override
  void onInit() {
    super.onInit();
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
