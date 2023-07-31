import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/color_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';
import 'package:gb_latest_version/app/modules/screens/status_saver_screen/views/open_story_screen.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:saf/saf.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class StatusSaverScreenController extends GetxController {
  //TODO: Implement ScreensStatusSaverScreenController

  RxBool isWhatsappBusiness = false.obs;

  Future<bool> permission() async {
    var storage = await Permission.storage.status;
    var manageExternalStorage = await Permission.manageExternalStorage.status;

    log('result[Permission.storage] -> ${storage}');
    log('result[Permission.manageExternalStorage] -> ${manageExternalStorage}');

    if (storage == PermissionStatus.granted && manageExternalStorage == PermissionStatus.granted) {
      return true;
    } else {
      return false;
      ConstantsWidget.dialogBox(onTapOK: () => openAppSettings().then((value) => Get.back()), onTapCancel: () => Get.back());
      log('Please Grant permission...@@');
    }
  }


  Saf saf = Saf(Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses').path);
  permissionView() {
    double width = 100.w;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Click on this button and Allow permission to\n'
            ' access your status',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 3.8.w, fontWeight: FontWeight.w400)),
        SizedBox(height: 20.sp),
        InkWell(
          onTap: () async {
            if(isWhatsappBusiness.value == true) {
              getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp Business/Media/.Statuses/');
            } else {
              getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/');
            }
            // await Saf.releasePersistedPermissions();
            // await Permission.storage.request();
            // await saf.getDirectoryPermission(isDynamic: true);
            // await saf.cache().then((value) => getStories(folder_path: value));
          },
          child: Container(
            width: width * 0.52,
            height: 29.sp,
            decoration: BoxDecoration(
                color: ConstantsColor.greenBorderColor.withAlpha(80),
                borderRadius: BorderRadius.circular(50.sp),
                border: Border.all(color: ConstantsColor.greenBorderColor)
            ),
            alignment: Alignment.center,
            child: Text('Allow storage access', style: TextStyle(color: Colors.white, fontSize: 15.5.sp, fontWeight: FontWeight.w400)),
          ),
        )
      ],
    );
  }


  Widget storiesGrid({required List data}) {
    print('data ->>> $data');
    double spacing = 15.sp;
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: spacing, right: spacing, bottom: spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: spacing, mainAxisSpacing: spacing, childAspectRatio: 1),
      itemCount: data.length,
      itemBuilder: (context, index) {
        File image = File(data[index]);
        print('image ->>> $image');

        if(image.path.split('/').last.split('.').last == 'jpg') {
          return InkWell(
            onTap: () {
              Get.to(const OpenStoryScreenView(), arguments: image.path);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.sp),
                    boxShadow: const [BoxShadow(offset: Offset(0,1), color: Colors.black26, blurRadius: 4)]
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.sp),
                    child: Image.file(File(image.path), fit: BoxFit.cover)
                )
            ),
          );
        }
        else if(image.path.split('/').last.split('.').last == 'mp4') {

          return InkWell(
            onTap: () {
              Get.to(const OpenStoryScreenView(), arguments: image.path);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 45.sp,
                  width: 100.w,
                  child: FutureBuilder<Uint8List>(
                      future: videoThumbnails(path: image.path),
                      builder: (BuildContext context,AsyncSnapshot<Uint8List> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
                          return const Center(child: CupertinoActivityIndicator());
                        } else {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(14.sp),
                              child: Image.memory(snapshot.data!, fit: BoxFit.cover)
                          );
                        }
                      }
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(14.sp),
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
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  ///Video Thumbnail
  Future<Uint8List> videoThumbnails({required String path}) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    return uint8list!;
  }

  ///No Data Found
  Widget noDataFound() {
    return Center(
      child: Text('No Stories Available',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 3.8.w, fontWeight: FontWeight.w400)),
    );
  }

  RxBool isSyncWhatsappStories = false.obs;
  RxBool isSyncStories = false.obs;
  RxList stories = [].obs;
  RxList bussinessStories = [].obs;

  getStories({required String folder_path}) {
    print('folder_path -> $folder_path');
    final dir = Directory(folder_path);

    if(dir.existsSync()) {
      if(isWhatsappBusiness.value == false) {
        ///Received
        dir.listSync().forEach((element) {
          if(element is File && element.path.endsWith(".jpg") || element.path.endsWith(".mp4")) {
            print('element -> ${element.path}');
            if(!stories.contains(element.path)) {
              stories.value.add(element.path);
            }
          }
        });
        // stories.value.removeWhere((element1) => element1.any((element) => element is Directory) || element1.any((element) => element.path.split('/').last == '.nomedia'));
      } else {
        ///Received
        dir.listSync().forEach((element) {
          if(element is File && element.path.endsWith(".jpg") || element.path.endsWith(".mp4")) {
            print('element -> ${element.path}');
            if(!bussinessStories.contains(element.path)) {
              bussinessStories.value.add(element.path);
            }
          }
        });
        // bussinessStories.value.removeWhere((element1) => element1.any((element) => element is Directory) || element1.any((element) => element.path.split('/').last == '.nomedia'));
      }
    }
    print('stories -> ${stories}');
  }

  ///Get Story data
  // Future getStories({dynamic paths}) async {
  //   try{
  //
  //     if(isWhatsappBusiness.value == false) {
  //       isSyncStories.value = true;
  //       for (String path in paths) {
  //         if (path.endsWith(".jpg") || path.endsWith(".mp4")) {
  //           stories.value.add(path);
  //         }
  //       }
  //       stories.value.removeWhere((story) => !story.split('/').last.endsWith('.jpg') && !story.split('/').last.endsWith('.mp4'));
  //     } else {
  //       isSyncWhatsappStories.value = true;
  //       for (String path in paths) {
  //         if (path.endsWith(".jpg") || path.endsWith(".mp4")) {
  //           bussinessStories.value.add(path);
  //         }
  //       }
  //       bussinessStories.value.removeWhere((story) => !story.split('/').last.endsWith('.jpg') && !story.split('/').last.endsWith('.mp4'));
  //     }
  //     print('stories -> ${stories}');
  //     print('bussinessStories -> ${bussinessStories}');
  //   } catch(err) {
  //     print('err getStories -> ${err}');
  //   }
  //   update();
  // }


  ///video player
  late VideoPlayerController videoPlayerController;

  RxBool isPermissionGranted = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isPermissionGranted.value = await permission();
    if(isPermissionGranted.value == true) {
      if(isWhatsappBusiness.value == true) {
        getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp Business/Media/.Statuses/');
      } else {
        getStories(folder_path: '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/');
      }
      // controller.update();
    }
    update();
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
