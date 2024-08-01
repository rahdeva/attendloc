import 'package:attendloc/resources/resources.dart';
import 'package:attendloc/routes/page_names.dart';
import 'package:attendloc/utills/widget/snackbar/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool isObscure = true;
  RxBool isLoading = false.obs;

  void loginEmail({
    required BuildContext context,
    required String emailInput,
    required String passwordInput,
  }) async {
    isLoading.value = true;
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailInput,
          password: passwordInput,
        );

        isLoading.value = false;
        Get.offAllNamed(PageName.ATTENDANCE);

        // UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        //   email: emailInput,
        //   password: passwordInput,
        // );
        // isLoading.value = false;
        // if (userCredential.user!.emailVerified == true) {
        //   Get.offAllNamed(PageName.ATTENDANCE);
        // } else {
        //   Get.defaultDialog(
        //     title: "Belum Tervefirikasi",
        //     middleText:
        //         "Apakah kamu ingin mengirim email verifikasi kembali ? Mohon cek juga pada bagian spam",
        //     actions: [
        //       OutlinedButton(
        //         onPressed: () => Get.back(), // menutup dialog
        //         child: const Text("Cancel"),
        //       ),
        //       ElevatedButton(
        //         onPressed: () async {
        //           try {
        //             await userCredential.user!.sendEmailVerification();
        //             Get.back();
        //             PopUpWidget.successAndFailPopUp(
        //               // ignore: use_build_context_synchronously
        //               context: context, 
        //               titleString: "Success!", 
        //               middleText: "SKami telah mengirimkan email verifikasi. Buka email kamu untuk tahap verifikasi.", 
        //               buttonText: "OK"
        //             );
        //           } catch (e) {
        //             Get.back();
        //             SnackbarWidget.defaultSnackbar(
        //               icon: const Icon(
        //                 Icons.cancel,
        //                 color: AppColors.red,
        //               ),
        //               title: "Oops!",
        //               subtitle: "Kamu terlalu banyak meminta kirim email verifikasi.",
        //             );
        //           }
        //         },
        //         child: const Text("KIRIM LAGI"),
        //       ),
        //     ],
        //   );
        // }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          SnackbarWidget.defaultSnackbar(
            icon: const Icon(
              Icons.cancel,
              color: AppColors.red,
            ),
            title: "Oops!",
            subtitle: "Tidak ditemukan User dengan Email yang Anda masukkan.",
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Oops!", "");
          SnackbarWidget.defaultSnackbar(
            icon: const Icon(
              Icons.cancel,
              color: AppColors.red,
            ),
            title: "Oops!",
            subtitle: "Password yang Anda masukkan salah.",
          );
        } else {
          SnackbarWidget.defaultSnackbar(
            icon: const Icon(
              Icons.cancel,
              color: AppColors.red,
            ),
            title: "Oops!",
            subtitle: e.code,
          );
        }
      }
  }
}