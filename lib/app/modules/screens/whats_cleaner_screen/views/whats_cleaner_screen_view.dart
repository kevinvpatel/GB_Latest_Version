import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';
import 'package:gb_latest_version/app/modules/screens/whats_cleaner_screen/views/cleaner_screen.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/whats_cleaner_screen_controller.dart';

class WhatsCleanerScreenView extends GetView<WhatsCleanerScreenController> {
  const WhatsCleanerScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WhatsCleanerScreenController controller = Get.put(WhatsCleanerScreenController());
    double height = 100.h;
    double width = 100.w;

    return ConstantsWidget.backgroundTemplate(
      onTap: () {
        Get.back();
      },
      title: 'WhatsApp Cleaner',
      child: Obx(() => Container(
        width: width,
        height: height * 0.89,
        child: controller.percentage.value.toStringAsFixed(0) != '100' ? Center(
          child: loadingView(controller: controller),
        ) : Column(
          children: [
            SizedBox(height: 22.sp),
            Container(
              color: Colors.blue.withAlpha(80),
              height: height * 0.28,
              width: width,
            ),
            SizedBox(height: 22.sp),
            Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 14.sp, right: 14.sp),
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 17.sp),
                  itemCount: controller.cleaner_list.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        Get.to(CleanerScreenView(), arguments: controller.cleaner_list[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.sp),
                            border: Border.all(color: ConstantsColor.greenBorderColor)
                        ),
                        height: 37.5.sp,
                        padding: EdgeInsets.only(top: 17.sp, bottom: 17.sp, left: 18.sp, right: 12.sp),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.sp),
                              child: Image.asset(controller.cleaner_list[index]['image']),
                            ),
                            SizedBox(width: 15.sp),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.cleaner_list[index]['name'],
                                    style: TextStyle(color: Colors.white, fontSize: 16.5.sp, fontWeight: FontWeight.w500),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Files: ${controller.cleaner_list[index]['folder_num']}',
                                        style: TextStyle(color: Colors.white70, fontSize: 14.sp, fontWeight: FontWeight.w300),),
                                      Spacer(flex: 2),
                                      Text('Size: ${controller.cleaner_list[index]['folder_size']}',
                                        style: TextStyle(color: Colors.white70, fontSize: 14.sp, fontWeight: FontWeight.w300),),
                                      Spacer(flex: 3)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15.sp),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.delete, color: ConstantsColor.greenBorderColor,)
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
            )
          ],
        ),
      )),
    );
  }

  loadingView({required WhatsCleanerScreenController controller}) {
    double width = 100.w;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 7.sp,
          width: width * 0.7,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.sp),
            child: LinearProgressIndicator(
              minHeight: 5.sp,
              value: controller.percentage.value / 100,
              color: ConstantsColor.greenBorderColor,
              backgroundColor: Colors.white38,
            ),
          ),
        ),

        SizedBox(height: 12.sp),
        Text('Loading Folders',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16.sp)),
        Text('Please Wait...',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16.sp)),
        SizedBox(height: 12.sp),
        Text('(${controller.percentage.value.toStringAsFixed(2)} %)',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16.sp)),
      ],
    );
  }

}
