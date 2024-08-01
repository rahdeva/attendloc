import 'package:attendloc/routes/page_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  String? lokasiKerjaResult;

  final listLokasiKerja = [
    'WFH',
    'WF0 - SCTV TOWER',
    'WF0 - DAAN MOGOT',
    'WF0 - JALAN PANJANG',
    'WF0 - KAV 64 KEBON JERUK',
    'WF0 - LOKASI LAINNYA',
    'WF0 - STUDIO PENTA',
  ];

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(PageName.LOGIN);
    } catch (e) {
      Get.snackbar("TERJADI KESALAHAN", "Tidak dapat logout.");
    }
  }
}