import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  final String uid;
  final DateTime datetime;
  final String locationName;
  final int status;

  Attendance({
    required this.datetime,
    required this.uid,
    required this.locationName,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      datetime: (json['datetime'] as Timestamp).toDate(), 
      uid: json['uid'] as String,
      locationName: json['location_name'] as String,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': Timestamp.fromDate(datetime), 
      'uid': uid,
      'location_name': locationName,
      'status': status,
    };
  }
}