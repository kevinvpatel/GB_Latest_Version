import 'package:gb_latest_version/app/modules/screens/direct_message_screen/views/direct_message_screen_view.dart';
import 'package:gb_latest_version/app/modules/screens/status_saver_screen/views/status_saver_screen_view.dart';
import 'package:gb_latest_version/app/modules/screens/whats_cleaner_screen/views/whats_cleaner_screen_view.dart';
import 'package:gb_latest_version/app/modules/screens/whats_web_screen/views/whats_web_screen_view.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  //TODO: Implement HomeScreenController

  List<Map<String, dynamic>> listData = [
    {
      'image': 'assets/images/home_screen/whats_web.png',
      'title' : 'Whats Web',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/status_saver.png',
      'title' : 'Status Saver',
      'page' : const StatusSaverScreenView()
    },
    {
      'image': 'assets/images/home_screen/direct_msg.png',
      'title' : 'Direct Msg',
      'page' : const DirectMessageScreenView()
    },
    {
      'image': 'assets/images/home_screen/whats_cleaner.png',
      'title' : 'Whats Cleaner',
      'page' : const WhatsCleanerScreenView()
    },
    {
      'image': 'assets/images/home_screen/quick_message.png',
      'title' : 'Quick Message',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/blank_message.png',
      'title' : 'Blank Message',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/generate_qr.png',
      'title' : 'Generate QR',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/scan_qr.png',
      'title' : 'Scan QR',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/captions.png',
      'title' : 'Captions',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/decorate_text.png',
      'title' : 'Decorate Text',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/repeat_text.png',
      'title' : 'Repeat Text',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/emoticons.png',
      'title' : 'Emoticons',
      'page' : const WhatsWebScreenView()
    },
    {
      'image': 'assets/images/home_screen/stickers.png',
      'title' : 'Stickers',
      'page' : const WhatsWebScreenView()
    },
  ];

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
