import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/direct_message_screen_controller.dart';


class DirectMessageScreenView extends GetView<DirectMessageScreenController> {
  const DirectMessageScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = 100.h;
    double width = 100.w;

    DirectMessageScreenController controller = Get.put(DirectMessageScreenController());

    return ConstantsWidget.backgroundTemplate(
      title: 'Direct Message',
      child: Expanded(
        child: Column(
          children: [
            // SizedBox(height: 28.sp),
            Spacer(),
            Text('Send Message without saving contact number \n'
                'using Direct Message. Just Select Country, Enter \n'
                'Mobile Number & Message and Click Send \n'
                'Message.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w300),
            ),
            // SizedBox(height: 28.sp),
            Spacer(),
            fillUpBox(),
            // SizedBox(height: 28.sp),
            Spacer(),
            Obx(() => InkWell(
                borderRadius: BorderRadius.circular(17.sp),
                onTap: controller.isMessageEnable.value == false || controller.isPhoneNumberEnable.value == false ? null : () async {
                  print('controller.isMessageEnable.value -> ${controller.isMessageEnable.value}');
                  print('controller.isPhoneNumberEnable.value -> ${controller.isPhoneNumberEnable.value}');
                  String phoneNumber = controller.countryDialCode.value + controller.txtPhoneNumber.value.text;
                  phoneNumber = phoneNumber.replaceAll('+', '');
                  String text = controller.txtMessage.value.text;
                  await launchUrl(Uri.parse('https://wa.me/$phoneNumber?text=$text'), mode: LaunchMode.externalApplication);
                },
                child: Image.asset(ConstantsImage.send_button, height: height * 0.065)
            )),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  fillUpBox() {
    double width = 100.w;
    return Container(
      height: width * 0.92,
      width: width * 0.92,
      decoration: BoxDecoration(
        border: Border.all(color: ConstantsColor.greenBorderColor),
        borderRadius: BorderRadius.circular(28.sp),
      ),
      padding: EdgeInsets.only(left: 17.sp, right: 17.sp, top: 20.sp, bottom: 22.sp),
      child: Column(
        children: [
          Text('Enter Your Number', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.5.sp),),
          SizedBox(height: 25.sp),
          SizedBox(
              width: width * 0.35,
              height: 26.sp,
              child: IntlPhoneField(
                dropdownTextStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
                flagWidth: 21.sp,
                disableLengthCheck: true,
                flagsButtonPadding: EdgeInsets.only(left: 13.sp),
                decoration: InputDecoration(
                  fillColor: ConstantsColor.greenBorderColor.withAlpha(80),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantsColor.greenBorderColor),
                      borderRadius: BorderRadius.all(Radius.circular(15.sp))
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantsColor.greenBorderColor),
                      borderRadius: BorderRadius.all(Radius.circular(15.sp))
                  ),
                ),
                dropdownIconPosition: IconPosition.trailing,
                initialCountryCode: 'IN',
                onCountryChanged: (country) {
                  controller.countryDialCode.value = '+${country.dialCode}';
                },
              )
          ),
          SizedBox(height: 25.sp),
          textField(
              width: width,
              height: 27.sp,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18.sp),
              hintText: 'Input Phone Number',
              hintStyle: TextStyle(fontSize: 15.sp, color: Colors.green.shade300),
              controller: controller.txtPhoneNumber.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10), /// here char limit is 10
              ],
              onChanged: (phoneNumber) {
                if(phoneNumber.length >= 10) {
                  controller.isPhoneNumberEnable.value = true;
                } else {
                  controller.isPhoneNumberEnable.value = false;
                }
              },
          ),
          SizedBox(height: 20.sp),
          Expanded(
            child: textField(
                width: width,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18.sp),
                hintText: 'Input Message',
                hintStyle: TextStyle(fontSize: 15.sp, color: Colors.green.shade300),
                controller: controller.txtMessage.value,
                keyboardType: TextInputType.multiline,
                onChanged: (message) {
                  if(message != '') {
                    controller.isMessageEnable.value = true;
                  } else {
                    controller.isMessageEnable.value = false;
                  }
                },
            ),
          ),
        ],
      ),
    );
  }


  Widget textField({
    required double width,
    double? height,
    required String hintText,
    TextStyle? hintStyle,
    List<TextInputFormatter>? inputFormatters,
    required EdgeInsets padding,
    required TextInputType keyboardType,
    required TextEditingController controller,
    Function(String str)? onChanged
  }) {
    return Container(
      // color: Colors.blue,
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        expands: true,
        style: hintStyle,
        decoration: InputDecoration(
          contentPadding: padding,
          hintText: hintText,
          hintStyle: hintStyle,
          fillColor: ConstantsColor.greenBorderColor.withAlpha(80),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantsColor.greenBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(13.sp))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantsColor.greenBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(15.sp))
          ),
        ),
        inputFormatters: inputFormatters,
        cursorColor: Colors.white,
        minLines: null,
        maxLines: null,
        keyboardType: keyboardType,
        onChanged: onChanged,
      ),
    );
  }

}
