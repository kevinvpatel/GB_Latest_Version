import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/home_screen_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeScreenController controller = Get.put(HomeScreenController());
    double width = 100.w;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        drawer: drawer(scaffoldKey: scaffoldKey),
        backgroundColor: ConstantsColor.themeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 15.5.sp),
            Container(
              margin: EdgeInsets.only(left: 16.sp, right: 16.sp),
              child: Row(
                children: [
                  Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        borderRadius: BorderRadius.circular(15.sp),
                        child: Hero(
                            tag: 'btn',
                            child: Image.asset(ConstantsImage.appbar_menu, width: width * 0.1, height: width * 0.1)
                        ),
                      );
                    }
                  ),
                  SizedBox(width: 18.sp),
                  Text('GB Whats Tool', style: TextStyle(color: Colors.white, fontSize: 17.sp),),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: width * 0.1,
                      width: width * 0.1,
                      padding: EdgeInsets.all(8.sp),
                      child: Image.asset(ConstantsImage.appbar_detail),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                padding: EdgeInsets.only(top: 10.sp),
                child: GridView.builder(
                    itemCount: controller.listData.length,
                    padding: EdgeInsets.only(top: 15.sp, bottom: 20.sp),
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.55,
                        mainAxisSpacing: 20.sp
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          log('controller.listData[index][title] -> ${controller.listData[index]['title']}');
                          if(controller.listData[index]['title'] == 'Whats Cleaner' || controller.listData[index]['title'] == 'Status Saver') {
                            var storage = await Permission.storage.status;
                            var manageExternalStorage = await Permission.manageExternalStorage.status;

                            log('result[Permission.storage] -> ${storage}');
                            log('result[Permission.manageExternalStorage] -> ${manageExternalStorage}');

                            if (storage == PermissionStatus.granted && manageExternalStorage == PermissionStatus.granted) {
                              Get.to(controller.listData[index]['page']);
                            } else {
                              ConstantsWidget.dialogBox(onTapOK: () => openAppSettings().then((value) => Get.back()), onTapCancel: () => Get.back());
                              log('Please Grant permission...@@');
                            }
                          } else {
                            Get.to(controller.listData[index]['page']);
                          }
                        },
                        child: Image.asset(controller.listData[index]['image'])
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listTile({required String imagePath, required String title, required Function() onTap}) {
    double width = 100.w;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(imagePath, height: width * 0.12, width: width * 0.12),
          SizedBox(width: 17.sp),
          Text(title, style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 18.sp),),
        ],
      ),
    );
  }

  Widget drawer({required GlobalKey<ScaffoldState> scaffoldKey}) {
    double width = 100.w;
    return Drawer(
      backgroundColor: ConstantsColor.greenBorderColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25.sp), bottomRight: Radius.circular(25.sp)),
      ),
      child: Container(
        padding: EdgeInsets.all(15.5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                return Hero(
                    tag: 'btn',
                    child: InkWell(
                      onTap: () {
                        print('presssssed');
                        // scaffoldKey.currentState?.closeDrawer();
                        Scaffold.of(context).closeDrawer();
                      },
                      child: Image.asset(ConstantsImage.close_button, width: width * 0.1, height: width * 0.1),
                    )
                );
              }
            ),
            Spacer(),
            Text('GB Latest Version', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21.sp),),
            Text('2023', style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 20.sp),),
            Spacer(),
            listTile(imagePath: ConstantsImage.drawer_share, title: 'Share App', onTap: () {}),
            SizedBox(height: 20.sp),
            listTile(imagePath: ConstantsImage.drawer_rating, title: 'Rate App', onTap: () {}),
            SizedBox(height: 20.sp),
            listTile(imagePath: ConstantsImage.drawer_policy, title: 'Privacy Policy', onTap: () {}),
            SizedBox(height: 20.sp),
            listTile(imagePath: ConstantsImage.drawer_tool, title: 'GB Whats Tool', onTap: () {}),
            SizedBox(height: 20.sp),
            listTile(imagePath: ConstantsImage.drawer_code, title: 'QR Code', onTap: () {}),
            SizedBox(height: 20.sp),
            listTile(imagePath: ConstantsImage.drawer_detail, title: 'How to use?', onTap: () {}),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }

}
