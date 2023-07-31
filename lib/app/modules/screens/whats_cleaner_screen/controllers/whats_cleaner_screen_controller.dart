import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class WhatsCleanerScreenController extends GetxController {
  //TODO: Implement ScreensWhatsCleanerScreenController

  List<Map<String, dynamic>> cleaner_list = [
    {
      'image' : ConstantsImage.status_image,
      'folder_name' : '.Statuses',
      'name' : 'Status',
      'folder_path' : '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.images_image,
      'folder_name' : 'WhatsApp Images',
      'name' : 'Images',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Images/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.videos_image,
      'folder_name' : 'WhatsApp Video',
      'name' : 'Videos',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Video/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.documents_image,
      'folder_name' : 'WhatsApp Documents',
      'name' : 'Documents',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Documents/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.audio_image,
      'folder_name' : 'WhatsApp Audio',
      'name' : 'Audio',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Audio/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.stickers_image,
      'folder_name' : 'WhatsApp Stickers',
      'name' : 'Stickers',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Stickers/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.wallpaper_image,
      'folder_name' : 'WhatsApp Profile Photos',
      'name' : 'Wallpaper',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Profile Photos/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
    {
      'image' : ConstantsImage.GIFs_image,
      'folder_name' : 'WhatsApp Animated Gifs',
      'name' : 'GIFs',
      'folder_path' : '/storage/emulated/0/WhatsApp/Media/WhatsApp Animated Gifs/',
      'folder_size' : '0',
      'folder_num' : '0',
    },
  ];


  // RxList<FileSystemEntity> listSentPath = <FileSystemEntity>[].obs;
  RxList<Map<FileSystemEntity, int>> listReceivedPath = <Map<FileSystemEntity, int>>[].obs;
  RxList<Map<FileSystemEntity, int>> listSentPath = <Map<FileSystemEntity, int>>[].obs;

  RxBool isSent = false.obs;

  getData({required String folder_path, required String folder_name}) async {
    print('folder_path -> $folder_path');
    print('folder_name -> $folder_name');
    final dir = Directory(folder_path);
    listSentPath.clear();
    listReceivedPath.clear();

    if(dir.existsSync()) {
      ///Received
      Directory(folder_path).listSync().forEach((element) {
       if(element is File) {
         print('element -> ${element.path}');
         listReceivedPath.value.add({element : File(element.path).lengthSync()});
       }
      });
      listReceivedPath.value.removeWhere((element1) => element1.keys.any((element) => element is Directory) || element1.keys.any((element) => element.path.split('/').last == '.nomedia'));
      print('1.listReceivedPath -> ${listReceivedPath.value}');


      ///Sent
      if(folder_name != 'Status') {
        Directory('$folder_path/Sent/').listSync().forEach((element) {
          listSentPath.value.add({element : File(element.path).lengthSync()});
        });
        listSentPath.value.removeWhere((element1) => element1.keys.any((element) => element is Directory) || element1.keys.any((element) => element.path.split('/').last == '.nomedia'));
        print('1.listSentPath -> ${listSentPath.value}');
      }
    }
  }

  Map<String, String> dirStatSync({required String dirPath}) {
    int fileNum = 0;
    int totalSize = 0;
    var dir = Directory(dirPath);
    try {
      if (dir.existsSync()) {
        dir.listSync(recursive: true, followLinks: false)
            .forEach((FileSystemEntity entity) {
          if (entity is File) {
            fileNum++;
            totalSize += entity.lengthSync();
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
    print('folderNum -> $fileNum');
    String size = '0 Bs';
    if(totalSize > 0) {
      size = getFileSizeString(bytes: totalSize, decimals: 2);
    }

    return {'folderNum': fileNum.toString(), 'size': size};
  }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = [" Bs", " KBs", " MBs", " GBs", " TBs"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
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

  RxDouble percentage = 0.0.obs;
  RxDouble percentageCounter = 0.0.obs;

  RxBool isSelectAll = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    for(int index = 0; index < cleaner_list.length; index++) {

      await Future.delayed(const Duration(milliseconds: 100));
      percentageCounter.value++;
      percentage.value = (percentageCounter.value) / cleaner_list.length * 100;
      print('percentage.value -> ${percentage.value}');

      Map<String, String> dirDetails = dirStatSync(dirPath: cleaner_list[index]['folder_path']);
      cleaner_list[index]['folder_num'] = dirDetails['folderNum'];
      cleaner_list[index]['folder_size'] = dirDetails['size'];
    }

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
