import 'dart:convert';

import 'user_model.dart';
import '../Modules/database.dart';
import 'package:firebase_database/firebase_database.dart';

class DataModel {
  final List<UserModel>? userDetails;
  DatabaseReference? id;

  DataModel({this.userDetails});

  factory DataModel.fromJson(Map<String, dynamic> json1, String uid) {
    List<UserModel> getUserDetailsList(Map<String, dynamic> jsonList) {
      List<UserModel> userList = [];
      if (jsonList != null) {
        jsonList.keys.forEach((key) {
          UserModel user =
              UserModel.fromJson(jsonDecode(jsonEncode(jsonList[key])), key);
          user.setId(databaseReference.child('$uid/userDetails/' + key));
          userList.add(user);
        });
      }
      return userList;
    }

    return DataModel(
      userDetails:
          getUserDetailsList(jsonDecode(jsonEncode(json1['userDetails']))),
    );
  }

  void setId(DatabaseReference id) {
    this.id = id;
  }
}


// "$uid": {
// ".read": "$uid === auth.uid || auth.uid === '8daK26SfAmTAguFwBdNBAzTstuK2'",
// ".write": "$uid === auth.uid || auth.uid === '8daK26SfAmTAguFwBdNBAzTstuK2'"
// }