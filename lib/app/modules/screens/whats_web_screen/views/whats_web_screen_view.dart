import 'package:flutter/material.dart';
import 'package:gb_latest_version/app/data/image_constants.dart';
import 'package:gb_latest_version/app/data/widget_constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/whats_web_screen_controller.dart';

class WhatsWebScreenView extends GetView<WhatsWebScreenController> {
  const WhatsWebScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WhatsWebScreenController controller = Get.put(WhatsWebScreenController());
    double width = 100.w;

    return Scaffold(
      backgroundColor: Colors.teal.shade500,
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
                        onTap: () {},
                        borderRadius: BorderRadius.circular(15.sp),
                        child: Hero(
                            tag: 'btn',
                            child: Image.asset(ConstantsImage.appbar_back, width: width * 0.1, height: width * 0.1)
                        ),
                      );
                    }
                ),
                SizedBox(width: 18.sp),
                Text('WhatsWeb', style: TextStyle(color: Colors.white, fontSize: 17.sp),),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 15.sp),
          Expanded(
            child: InAppWebView(
              key: controller.webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse("https://web.whatsapp.com/")),
              initialOptions: controller.options,
              onWebViewCreated: (ctrl) {
                controller.webViewController = ctrl;
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },
              onLoadStop: (controller, url) async {

              },
              onLoadError: (controller, url, code, message) {

              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {

                }
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
          )
        ],
      ),
    );
  }
}
