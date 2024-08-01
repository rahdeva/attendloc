import 'package:attendloc/feature/add_location/add_location_binding.dart';
import 'package:attendloc/feature/add_location/add_location_page.dart';
import 'package:attendloc/feature/attendance/attendance_binding.dart';
import 'package:attendloc/feature/attendance/attendance_page.dart';
import 'package:attendloc/feature/choose_location/choose_location_binding.dart';
import 'package:attendloc/feature/choose_location/choose_location_page.dart';
import 'package:attendloc/feature/login/login_binding.dart';
import 'package:attendloc/feature/login/login_page.dart';
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
      name: PageName.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PageName.ATTENDANCE,
      page: () => const AttendancePage(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: PageName.ADD_LOCATION,
      page: () => const AddLocationPage(),
      binding: AddLocationBinding(),
    ),
    GetPage(
      name: PageName.CHOOSE_LOCATION,
      page: () => const ChooseLocationPage(),
      binding: ChooseLocationBinding(),
    ),
  ];
}
