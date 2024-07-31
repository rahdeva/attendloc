import 'package:attendloc/feature/home/home_binding.dart';
import 'package:attendloc/feature/home/home_page.dart';
import 'package:attendloc/feature/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PageName.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
