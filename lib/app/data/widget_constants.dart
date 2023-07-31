import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

abstract class ConstantsWidget {

  static Widget backgroundTemplate({
    // required String buttonImage,
    Function()? onTap,
    required Widget child,
    required String title,
  }) {
    double width = 100.w;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ConstantsColor.themeColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 27.sp),
          Container(
            margin: EdgeInsets.only(left: 16.sp, right: 16.sp),
            child: Row(
              children: [
                Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Hero(
                        tag: 'btn',
                        child: Image.asset(ConstantsImage.appbar_back, width: width * 0.1, height: width * 0.1)
                      ),
                    );
                  }
                ),
                SizedBox(width: 18.sp),
                Text(title, style: TextStyle(color: Colors.white, fontSize: 17.sp),),
                Spacer(),
              ],
            ),
          ),
          child
        ],
      ),
    );
  }


  static dialogBox({required Function() onTapOK, required Function() onTapCancel,}) {
    double height = 100.h;
    double width = 100.w;
    double radius = 20.sp;

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.2,
              width: width,
              decoration: BoxDecoration(
                  color: ConstantsColor.themeColor,
                  border: Border.all(color: ConstantsColor.greenBorderColor),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(radius.sp), topLeft: Radius.circular(radius.sp))
              ),
              alignment: Alignment.center,
              child: Text('Do You Want To Grand Storage Permission Access??',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: 7.sp),
            SizedBox(
              width: width,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius.sp)),
                      onTap: onTapOK,
                      child: Container(
                        height: 30.sp,
                        decoration: BoxDecoration(
                            color: ConstantsColor.themeColor,
                            border: Border.all(color: ConstantsColor.greenBorderColor),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius.sp))
                        ),
                        alignment: Alignment.center,
                        child: Text('OK', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                  SizedBox(width: 7.sp),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius.sp)),
                      onTap: onTapCancel,
                      child: Container(
                        height: 30.sp,
                        decoration: BoxDecoration(
                            color: ConstantsColor.themeColor,
                            border: Border.all(color: ConstantsColor.greenBorderColor),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius.sp))
                        ),
                        alignment: Alignment.center,
                        child: Text('CANCEL', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }


}