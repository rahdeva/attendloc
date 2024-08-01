import 'package:attendloc/model/attendance.dart';
import 'package:attendloc/model/location.dart';
import 'package:attendloc/model/user_data.dart';
import 'package:attendloc/resources/resources.dart';
import 'package:attendloc/routes/page_names.dart';
import 'package:attendloc/utills/widget/pop_up/pop_up_widget.dart';
import 'package:attendloc/utills/widget/snackbar/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttendanceController extends GetxController {
  static AttendanceController find = Get.find();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  String? officeResult;
  RxBool isOfficeChoosen = false.obs;
  UserData? userData;
  List<OfficeLocation> listOffices = []; 
  List<String> officeNames = [];
  List<Attendance> listAttendance = [];
  String uid = FirebaseAuth.instance.currentUser!.uid;

  String timeString = DateFormat('hh:mm a').format(DateTime.now());
  String dateString = DateFormat('EEE, d MMM yyyy').format(DateTime.now());

  @override
  void onInit() {
    getProfile();
    getOffices();
    getAttendance();
    super.onInit();
  }

  void refreshPage() async {
    getProfile();
    getOffices();
    getAttendance();
    officeResult = null;
    isOfficeChoosen.value = false;
    update();
    refreshController.refreshCompleted();
  }

  void getProfile() async {
    try {
      DocumentSnapshot<UserData> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .get();
      
      userData = snapshot.data();
    } catch (e) {
      Get.snackbar("Error", "Failed to get profile data.");
    }
    update();
  }

  void getOffices() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('location')
        .get();
      listOffices = snapshot.docs
        .map((doc) => OfficeLocation.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
      officeNames = listOffices.map((location) => location.name).toList();
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Failed to get office data.",
      );
    }
    update();
  }

  void getAttendance() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('uid', isEqualTo: uid)
        .get();
      
      listAttendance = snapshot.docs
        .map((doc) => Attendance.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Failed to get attendance data.",
      );
    }
    update();
  }

  void addAttendance(BuildContext context, int status) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          SnackbarWidget.defaultSnackbar(
            icon: const Icon(
              Icons.cancel,
              color: AppColors.red,
            ),
            title: "Permission Denied",
            subtitle: "Location permission is required to track attendance.",
          );
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Permission Denied Forever",
          subtitle: "Location permission is permanently denied. Please enable it in settings.",
        );
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      OfficeLocation? selectedOffice = listOffices.firstWhere(
        (office) => office.name == officeResult,
      );

      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        selectedOffice.latitude,
        selectedOffice.longitude,
      );

      if (distanceInMeters > 50) {
        SnackbarWidget.defaultSnackbar(
          icon: const Icon(
            Icons.cancel,
            color: AppColors.red,
          ),
          title: "Failed",
          subtitle: "You are too far from the office location.",
        );
        return;
      }

      Attendance newAttendance = Attendance(
        datetime: DateTime.now(),
        uid: uid,
        status: status,
        locationName: officeResult ?? '-',
      );

      await FirebaseFirestore.instance
        .collection('attendance')
        .add(newAttendance.toJson());

      getAttendance();
      officeResult = null;
      isOfficeChoosen.value = false;
      getOffices();

      PopUpWidget.successAndFailPopUp(
        // ignore: use_build_context_synchronously
        context: context, 
        titleString: "Success!", 
        middleText: "Attendance added successfully", 
        buttonText: "OK"
      );
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Failed to add attendance.",
      );
    }
    update();
  }
  
  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(PageName.LOGIN);
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Failed to Logout",
      );
    }
  }
}