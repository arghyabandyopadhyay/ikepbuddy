import 'dart:convert';

import 'package:ikepbuddy/Models/pair_model.dart';

import 'user_model.dart';
import '../Modules/database.dart';
import 'package:firebase_database/firebase_database.dart';

class DataModel {
  final List<PairModel>? patients;
  final List<UserModel>? hospitalDetails;
  DatabaseReference? id;

  DataModel({this.hospitalDetails, this.patients});

  factory DataModel.fromJson(Map<String, dynamic> json1, String uid) {
    List<PairModel> getPatients(Map<String, dynamic>? jsonList) {
      List<PairModel> patients = [];
      if (jsonList != null) {
        jsonList.keys.forEach((key) {
          PairModel patient =
              PairModel.fromJson(jsonDecode(jsonEncode(jsonList[key])));
          patient.setId(databaseReference.child('$uid/patients/' + key));
          patients.add(patient);
        });
      }
      return patients;
    }

    List<UserModel> getUserDetailsList(Map<String, dynamic> jsonList) {
      List<UserModel> userList = [];
      if (jsonList != null) {
        jsonList.keys.forEach((key) {
          UserModel user =
              UserModel.fromJson(jsonDecode(jsonEncode(jsonList[key])), key);
          user.setId(databaseReference.child('$uid/hospitalDetails/' + key));
          userList.add(user);
        });
      }
      return userList;
    }

    return DataModel(
        hospitalDetails: getUserDetailsList(
            jsonDecode(jsonEncode(json1['hospitalDetails']))),
        patients: getPatients(jsonDecode(jsonEncode(json1['patients']))));
  }

  void setId(DatabaseReference id) {
    this.id = id;
  }
}


// "$uid": {
// ".read": "$uid === auth.uid || auth.uid === '8daK26SfAmTAguFwBdNBAzTstuK2'",
// ".write": "$uid === auth.uid || auth.uid === '8daK26SfAmTAguFwBdNBAzTstuK2'"
// }