import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:gb_latest_version/app/modules/screens/status_saver_screen/controllers/status_saver_screen_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

class OpenStoryScreenView extends GetView<StatusSaverScreenController> {
  const OpenStoryScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    StatusSaverScreenController controller = Get.put(StatusSaverScreenController());
    double height = 100.h;
    double width = 100.w;
    String image = Get.arguments;

    /// loadVideoPlayer
    controller.videoPlayerController = VideoPlayerController.file(File(image))
      ..addListener(() {
        controller.update();
      })
      ..initialize().then((value) => controller.update())
      ..play();
    print('controller.videoPlayerController.value.isPlaying 11 -> ${controller.videoPlayerController.value.duration.toString()}');

    return WillPopScope(
      onWillPop: () {
        controller.videoPlayerController.pause();
        controller.videoPlayerController.dispose();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          height: height,
          width: width,
          child: image.split('/').last.split('.').last == 'jpg'
              ? Image.file(File(image), fit: BoxFit.fitWidth)
              : GetBuilder(
              init: StatusSaverScreenController(),
              builder: (controller) {
                return Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Container(
                        height: height * 0.6,
                        width: width,
                        child: controller.videoPlayerController.value.isInitialized
                            ? VideoPlayer(controller.videoPlayerController)
                            : const Center(child: Text('Please Wait!!', style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                    GetBuilder(
                      init: StatusSaverScreenController(),
                      builder: (ctrl) {
                        if(controller.videoPlayerController.value.isPlaying) {
                          return const SizedBox.shrink();
                        } else {
                          return Center(
                            child: InkWell(
                              onTap: () {
                                try {
                                  // if(controller.videoPlayerController.value.isPlaying){
                                  //   controller.videoPlayerController.pause();
                                  // }else{
                                    controller.videoPlayerController.play();
                                  // }
                                } catch(err) {
                                  print('vid play err -> $err');
                                }
                                controller.update();
                              },
                              child: Container(
                                height: 30.sp,
                                width: 30.sp,
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: EdgeInsets.only(left: 6.sp),
                                child: Icon(CupertinoIcons.play_arrow_solid, size: 20.sp, color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }
                    )
                  ],
                );
              }
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () async {
            String directoryPath = "/storage/emulated/0/Download/";

            bool dirDownloadExists = await Directory(directoryPath).exists();
            if(dirDownloadExists){
              directoryPath = "/storage/emulated/0/Download/GB Latest Version/";
              Directory(directoryPath).createSync();
            }else{
              directoryPath = "/storage/emulated/0/Downloads/GB Latest Version/";
              Directory(directoryPath).createSync();
            }

            String fileName;
            if(image.endsWith(".jpg")) {
              fileName = '${directoryPath}gb_latest_version_${DateTime.now().microsecondsSinceEpoch}.jpg';
            } else {
              fileName = '${directoryPath}gb_latest_version_${DateTime.now().microsecondsSinceEpoch}.mp4';
            }

            bool isFileExist = File(fileName).existsSync();
            if(!isFileExist) {
              File(fileName).createSync();
              await File(image).copy(fileName).then((value) =>
                  Fluttertoast.showToast(msg: 'Download successfully at ${directoryPath}gb_latest_version_${DateTime.now().microsecondsSinceEpoch}.jpg', toastLength: Toast.LENGTH_LONG)
              );
            } else {
              Fluttertoast.showToast(msg: '${directoryPath}gb_latest_version_${DateTime.now().microsecondsSinceEpoch}.jpg  Existed Already', toastLength: Toast.LENGTH_LONG);
            }

          },
          child: Container(
            width: 34.sp,
            height: 34.sp,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10.sp),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.sp),
                  border: Border.all(width: 1, color: Colors.grey.shade400)
              ),
              padding: EdgeInsets.all(7.5.sp),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [Colors.white, Color.fromRGBO(137, 241, 74, 1), Color.fromRGBO(39, 156, 15, 1)],
                      ),
                      borderRadius: BorderRadius.circular(100.sp)
                  ),
                  padding: EdgeInsets.all(12.sp),
                  child: Image.asset(ConstantsImage.sticker_download_icon)
              ),
            ),
          ),
        ),
      ),
    );
  }
}