import 'package:get/get.dart';

import '../modules/home_screen/bindings/home_screen_binding.dart';
import '../modules/home_screen/views/home_screen_view.dart';
import '../modules/onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/onboarding_screen/views/onboarding_screen_view.dart';
import '../modules/screens/direct_message_screen/bindings/direct_message_screen_binding.dart';
import '../modules/screens/direct_message_screen/views/direct_message_screen_view.dart';
import '../modules/screens/status_saver_screen/bindings/status_saver_screen_binding.dart';
import '../modules/screens/status_saver_screen/views/status_saver_screen_view.dart';
import '../modules/screens/whats_cleaner_screen/bindings/whats_cleaner_screen_binding.dart';
import '../modules/screens/whats_cleaner_screen/views/whats_cleaner_screen_view.dart';
import '../modules/screens/whats_web_screen/bindings/whats_web_screen_binding.dart';
import '../modules/screens/whats_web_screen/views/whats_web_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => const OnboardingScreenView(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => const HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.WHATS_WEB_SCREEN,
      page: () => const WhatsWebScreenView(),
      binding: WhatsWebScreenBinding(),
    ),
    GetPage(
      name: _Paths.STATUS_SAVER_SCREEN,
      page: () => const StatusSaverScreenView(),
      binding: StatusSaverScreenBinding(),
    ),
    GetPage(
      name: _Paths.DIRECT_MESSAGE_SCREEN,
      page: () => const DirectMessageScreenView(),
      binding: DirectMessageScreenBinding(),
    ),
    GetPage(
      name: _Paths.WHATS_CLEANER_SCREEN,
      page: () => const WhatsCleanerScreenView(),
      binding: WhatsCleanerScreenBinding(),
    ),
  ];
}
