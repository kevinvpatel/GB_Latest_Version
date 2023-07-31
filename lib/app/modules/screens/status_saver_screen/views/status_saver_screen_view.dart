import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/status_saver_screen_controller.dart';

class StatusSaverScreenView extends GetView<StatusSaverScreenController> {
  const StatusSaverScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    StatusSaverScreenController controller = Get.put(StatusSaverScreenController());
    double height = 100.h;
    double width = 100.w;

    // if(controller.isPermissionGranted.value == true) {
    //   if(controller.isWhatsappBusiness.value == true) {
    //     controller.getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp Business/Media/.Statuses/');
    //     controller.isWhatsappBusiness.value = false;
    //   } else {
    //     controller.getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/');
    //     controller.isWhatsappBusiness.value = true;
    //   }
    //   // controller.update();
    // }

    return ConstantsWidget.backgroundTemplate(
      title: 'Status Saver',
      child: Padding(
        padding: EdgeInsets.only(left: 17.sp, right: 17.sp),
        child: Container(
          height: height * 0.89,
          child: Column(
            children: [
              SizedBox(height: 25.sp),
              Text('Select WhatsApp Type', style: TextStyle(color: Colors.white, fontSize: 17.5.sp, fontWeight: FontWeight.w400),),
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => tabButton(
                      title: 'WhatsApp',
                      color: controller.isWhatsappBusiness.value ? Colors.transparent : ConstantsColor.greenBorderColor.withAlpha(80),
                      borderColor: controller.isWhatsappBusiness.value ? Colors.white : ConstantsColor.greenBorderColor,
                      textColor: controller.isWhatsappBusiness.value ? ConstantsColor.greenBorderColor : Colors.white,
                      onTap: () {
                        controller.isWhatsappBusiness.value = false;
                        controller.getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/');
                        // controller.update();
                      }
                  )),
                  Obx(() => tabButton(
                      title: 'WA Business',
                      color: !controller.isWhatsappBusiness.value ? Colors.transparent : ConstantsColor.greenBorderColor.withAlpha(80),
                      borderColor: !controller.isWhatsappBusiness.value ? Colors.white : ConstantsColor.greenBorderColor,
                      textColor: !controller.isWhatsappBusiness.value ? ConstantsColor.greenBorderColor : Colors.white,
                      onTap: () {
                        controller.isWhatsappBusiness.value = true;
                        controller.getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp Business/Media/.Statuses/');
                        // controller.update();
                      }
                  )),
                ],
              ),
              SizedBox(height: 20.sp),
              Expanded(
                child: Obx(() {
                  print('controller.stories.value.length -> ${controller.stories.value.length}');
                  if(controller.isWhatsappBusiness.value == true) {
                    return controller.isPermissionGranted.value == false
                        ? controller.permissionView()
                        : controller.bussinessStories.value.length > 0 ? controller.storiesGrid(data: controller.bussinessStories.value) : controller.noDataFound();
                  } else {
                    return controller.isPermissionGranted.value == false
                        ? controller.permissionView()
                        : controller.stories.value.length > 0 ? controller.storiesGrid(data: controller.stories.value) : controller.noDataFound();
                  }
                })
              )
            ],
          )
        ),
      ),
    );
  }

  tabButton({required String title, required Color color, required Color borderColor, required Color textColor, required Function() onTap}) {
    double width = 100.w;
    return InkWell(
      borderRadius: BorderRadius.circular(15.sp),
      onTap: onTap,
      child: Container(
        width: width * 0.43,
        height: 28.sp,
        decoration: BoxDecoration(
          // color: ConstantsColor.greenBorderColor.withAlpha(80),
            color: color,
            borderRadius: BorderRadius.circular(15.sp),
            // border: Border.all(color: ConstantsColor.greenBorderColor)
            border: Border.all(color: borderColor)
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(color: textColor, fontSize: 17.sp, fontWeight: FontWeight.w400)),
      ),
    );
  }

}
