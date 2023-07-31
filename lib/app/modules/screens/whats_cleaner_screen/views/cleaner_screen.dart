import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';
import 'package:gb_latest_version/app/modules/screens/whats_cleaner_screen/controllers/whats_cleaner_screen_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CleanerScreenView extends GetView<WhatsCleanerScreenController> {
  const CleanerScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WhatsCleanerScreenController controller = Get.put(WhatsCleanerScreenController());
    double height = 100.h;
    double width = 100.w;

    controller.getData(folder_path: Get.arguments['folder_path'], folder_name: Get.arguments['name']);

    // RxBool isSelectItem = false.obs;
    // RxMap<int, bool> selectedItem = <int, bool>{}.obs;
    RxList<Map<FileSystemEntity, int>> selectedFiles = <Map<FileSystemEntity, int>>[].obs;

    return ConstantsWidget.backgroundTemplate(
      onTap: () {
        Get.back();
      },
      title: '${Get.arguments['name']} Cleaner',
      child: Container(
        width: width,
        height: height * 0.89,
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          children: [
            Get.arguments['name'] == 'Status' ? SizedBox.shrink() : SizedBox(height: 25.sp),
            Get.arguments['name'] == 'Status' ? SizedBox.shrink() : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => tabButton(
                    title: 'Received File',
                    color: controller.isSent.value ? Colors.transparent : ConstantsColor.greenBorderColor.withAlpha(80),
                    borderColor: controller.isSent.value ? Colors.white : ConstantsColor.greenBorderColor,
                    textColor: controller.isSent.value ? ConstantsColor.greenBorderColor : Colors.white,
                    onTap: () {
                      controller.isSent.value = false;
                      ///remove selected
                      // selectedItem.clear();
                      controller.isSelectAll.value = false;
                      selectedFiles.clear();
                      controller.update();
                    }
                )),
                Obx(() => tabButton(
                    title: 'Sent File',
                    color: !controller.isSent.value ? Colors.transparent : ConstantsColor.greenBorderColor.withAlpha(80),
                    borderColor: !controller.isSent.value ? Colors.white : ConstantsColor.greenBorderColor,
                    textColor: !controller.isSent.value ? ConstantsColor.greenBorderColor : Colors.white,
                    onTap: () {
                      controller.isSent.value = true;
                      ///remove selected
                      // selectedItem.clear();
                      controller.isSelectAll.value = false;
                      selectedFiles.clear();
                      controller.update();
                    }
                )),
              ],
            ),
            SizedBox(height: 15.sp),
            Expanded(
              child: GetBuilder(
                init: WhatsCleanerScreenController(),
                builder: (controller) {
                  print('controller.isSent.value -> ${controller.isSent.value}');
                  print('controller.listSentPath.length -> ${controller.listSentPath.length}');
                  print('controller.listReceivedPath.length -> ${controller.listReceivedPath.length}');
                  print(' ');
                  if(controller.listReceivedPath.value.length > 0) {
                    return Stack(
                      children: [
                        ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.isSent.value ? controller.listSentPath.length : controller.listReceivedPath.length,
                            separatorBuilder: (context, index) => SizedBox(height: 15.sp),
                            itemBuilder: (context, index) {

                              // selectedItem[index] = selectedItem[index] ?? false;

                              Map<FileSystemEntity, int> fileData = controller.isSent.value ? controller.listSentPath[index] : controller.listReceivedPath[index];

                              String size = controller.getFileSizeString(bytes: fileData.values.first, decimals: 2);

                              return InkWell(
                                onTap: () {
                                  if(selectedFiles.contains(fileData)) {
                                    selectedFiles.remove(fileData);
                                  } else {
                                    selectedFiles.add(fileData);
                                  }
                                  controller.update();
                                },
                                child: Container(
                                  height: 35.sp,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: selectedFiles.contains(fileData) ? ConstantsColor.greenBorderColor.withOpacity(0.55) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(15.sp),
                                      border: Border.all(color: ConstantsColor.greenBorderColor, width: 1.2)
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.sp),
                                        child: content(controller: controller, path: fileData.keys.first.absolute.path),
                                      ),
                                      SizedBox(width: 15.sp),
                                      Container(
                                        width: width * 0.58,
                                        child: Text(fileData.keys.first.absolute.path.split('/').last,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15.sp),),
                                      ),
                                      // selectedItem[index] == true || controller.isSelectAll.value
                                      selectedFiles.contains(fileData)
                                          ? IconButton(onPressed: null, icon: Icon(CupertinoIcons.checkmark_square_fill, color: ConstantsColor.greenBorderColor))
                                          : IconButton(onPressed: null, icon: Icon(CupertinoIcons.square, color: ConstantsColor.greenBorderColor))
                                      // controller.isSelectAll.value
                                      //     ? IconButton(onPressed: null, icon: Icon(CupertinoIcons.checkmark_square, color: ConstantsColor.greenBorderColor))
                                      //     : IconButton(
                                      //         onPressed: () async {
                                      //           if(controller.isSent.value) {
                                      //             controller.listSentPath.removeAt(index);
                                      //           } else {
                                      //             controller.listReceivedPath.removeAt(index);
                                      //           }
                                      //           await File(fileData.absolute.path).delete().then((value) {
                                      //
                                      //             print('11 -> ${fileData.path.split('/').last}');
                                      //             print('22 -> $index');
                                      //             print('delete completed');
                                      //           });
                                      //         },
                                      //         icon: Icon(Icons.delete, color: ConstantsColor.greenBorderColor,)
                                      //     )
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                        bottomButtons(
                            selectedFiles: selectedFiles,
                            items: controller.isSent.value ? controller.listSentPath : controller.listReceivedPath,
                            controller: controller
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('No ${Get.arguments['name']} available', style: TextStyle(color: ConstantsColor.greenBorderColor, fontSize: 17.sp),),
                    );
                  }
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  bottomButtons({required RxList<Map<FileSystemEntity, int>> selectedFiles, required RxList<Map<FileSystemEntity, int>> items, required WhatsCleanerScreenController controller}) {
    double width = 100.w;
    List<int> tempListBytes = [];
    RxString size = '0B'.obs;

    if(selectedFiles.isNotEmpty) {
      selectedFiles.value.forEach((element) {
        // print('selectedItems -> ${element.values.first}');
        tempListBytes.add(element.values.first);
      });

      int resultBytes = tempListBytes.reduce((a, b) => a + b);
      size.value = controller.getFileSizeString(bytes: resultBytes, decimals: 2);
      // print('size -> ${size}');
    }

    return Align(
      alignment: AlignmentDirectional(0, 1),
      child: Container(
        height: 36.sp,
        width: width,
        decoration: BoxDecoration(
            color: Colors.black,
            gradient: const LinearGradient(
              colors: [
                Colors.black,
                Colors.black87,
                Colors.black54,
              ],
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(0.0, 0.0),
              stops: [0.0, 0.8, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20.sp), topLeft: Radius.circular(20.sp))
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(20.sp),
                onTap: () {
                  if(selectedFiles.length == items.length) {
                    selectedFiles.clear();
                  } else if(selectedFiles.length != 0 && selectedFiles.length < items.length) {
                    selectedFiles.clear();
                    selectedFiles.addAll(items);
                  } else {
                    selectedFiles.addAll(items);
                  }
                  controller.isSelectAll.value =! controller.isSelectAll.value;
                  controller.update();
                },
                child: Container(
                  height: 36.sp,
                  decoration: BoxDecoration(
                      border: Border.all(color: ConstantsColor.greenBorderColor, width: 1.2),
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 18.sp),
                      Obx(() => Icon(selectedFiles.value.length == items.value.length ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square,
                          size: 21.5.sp, color: ConstantsColor.greenBorderColor),),
                      SizedBox(width: 12.sp),
                      Text('Select All', style: TextStyle(fontSize: 15.5.sp, color: Colors.white),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.sp),
            Expanded(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if(selectedFiles.isNotEmpty) {
                    print('selectedFiles.last.keys.first.path -> ${selectedFiles.length}');
                    //File Counter refresh
                    // final folderPath = selectedFiles.last.keys.first.path.replaceAll(selectedFiles.last.keys.first.path.split('/').last, '');
                    // if(controller.isSent.value) {
                    //   print('folderPath11 -> $folderPath');
                    //   Map<String, String> dirDetails = controller.dirStatSync(dirPath: folderPath);
                    //   // if(controller.cleaner_list.contains(Get.arguments)) {
                    //   //   controller.cleaner_list.firstWhere((element) => element == Get.arguments)
                    //   controller.cleaner_list[controller.cleaner_list.indexWhere((element) => element == Get.arguments)]['folder_num'] = dirDetails['folderNum'];
                    //   controller.cleaner_list[controller.cleaner_list.indexWhere((element) => element == Get.arguments)]['folder_size'] = dirDetails['size'];
                    //   // }
                    // } else {
                    //   print('folderPath -> $folderPath');
                    //   Map<String, String> dirDetails = controller.dirStatSync(dirPath: folderPath);
                    //   controller.cleaner_list[controller.cleaner_list.indexWhere((element) => element == Get.arguments)]['folder_num'] = dirDetails['folderNum'];
                    //   controller.cleaner_list[controller.cleaner_list.indexWhere((element) => element == Get.arguments)]['folder_size'] = dirDetails['size'];
                    // }

                    selectedFiles.forEach((file) async {
                      print('element path -> ${file.keys.first.path}');
                      await File(file.keys.first.path).delete().then((value) {
                        print('delete completed -> $value');
                        selectedFiles.removeWhere((element) => file == element);
                        if(controller.isSent.value) {
                          controller.listSentPath.removeWhere((element) => file == element);
                        } else {
                          controller.listReceivedPath.removeWhere((element) => file == element);
                        }
                        controller.update();
                      });
                    });

                  }

                },
                child: Container(
                  height: 36.sp,
                  decoration: BoxDecoration(
                      border: Border.all(color: ConstantsColor.greenBorderColor, width: 1.2),
                      borderRadius: BorderRadius.circular(20.sp)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 18.sp),
                      Icon(CupertinoIcons.delete, size: 20.sp, color: ConstantsColor.greenBorderColor),
                      SizedBox(width: 12.sp),
                      Expanded(
                        child: Obx(() => Text('Delete Selected\n Items (${size.value})',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(fontSize: 14.sp, color: Colors.white),)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  tabButton({required String title, double? width, required Color color, required Color borderColor, required Color textColor, required Function() onTap}) {
    double screenWidth = 100.w;
    return InkWell(
      borderRadius: BorderRadius.circular(15.sp),
      onTap: onTap,
      child: Container(
        width: width ?? screenWidth * 0.43,
        height: 28.sp,
        decoration: BoxDecoration(
          // color: ConstantsColor.greenBorderColor.withAlpha(80),
            color: color,
            borderRadius: BorderRadius.circular(15.sp),
            // border: Border.all(color: ConstantsColor.greenBorderColor)
            border: Border.all(color: borderColor, width: 1.5)
        ),
        alignment: Alignment.center,
        child: Text(title, style: TextStyle(color: textColor, fontSize: 17.sp, fontWeight: FontWeight.w400)),
      ),
    );
  }

  content({required String path, required WhatsCleanerScreenController controller}) {
    double radius = 12.sp;
    if(path.split('/').last.split('.').last == 'jpg') {
      return AspectRatio(
          aspectRatio: 1/1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: ConstantsColor.greenBorderColor, width: 1.2),
              borderRadius: BorderRadius.circular(radius + 1)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Image.file(File(path), fit: BoxFit.cover)
            )
          )
      );
    } else if(path.split('/').last.split('.').last == 'mp4' || path.split('/').last.split('.').last == '3gp') {
      return Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<Uint8List>(
              future: controller.videoThumbnails(path: path),
              builder: (BuildContext context,AsyncSnapshot<Uint8List> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
                  return const Center(child: CupertinoActivityIndicator());
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Container(
                      width: 32.sp,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                    ),
                  );
                }
              }
          ),
          Container(
            width: 32.sp,
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: const [BoxShadow(offset: Offset(0,1), color: Colors.black26, blurRadius: 4)]
            ),
          ),
          Center(
            child: Container(
              height: 23.sp,
              width: 23.sp,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.only(left: 6.sp),
              child: Icon(CupertinoIcons.play_arrow_solid, size: 16.sp, color: Colors.white),
            ),
          )
        ],
      );
    } else {
      return AspectRatio(
        aspectRatio: 1/1,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: ConstantsColor.greenBorderColor, width: 1.2),
            borderRadius: BorderRadius.circular(radius)
          ),
          child: Text(path.split('/').last.split('.').last.toUpperCase(), style: TextStyle(color: ConstantsColor.greenBorderColor.withAlpha(150), fontSize: 17.sp, fontWeight: FontWeight.w700),),
        ),
      );
    }
  }

}