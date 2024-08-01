// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        this.uid,
        this.email,
        this.role,
    });

    String? uid;
    String? email;
    String? role;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"] == null ? null : json["uid"],
        email: json["email"] == null ? null : json["email"],
        role: json["role"] == null ? null : json["role"]
    );

    Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "email": email == null ? null : email,
        "role": role == null ? null : role,
    };
}
