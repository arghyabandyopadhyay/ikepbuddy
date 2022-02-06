import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

class PairModel {
  DatabaseReference? id;
  int? index;
  String? name;
  String? uid;
  String? b;
  List<String>? h;
  int? age;
  double? k;
  int? pin;
  String? gender;
  String? mobileNo;
  String? dName;
  String? dB;
  List<String>? dH;
  int? dAge;
  double? dK;
  int? dPin;
  String? dGender;
  String? dMobileNo;
  int? priority;
  List<String>? sPref;
  String? sd;
  String? masterFilter;
  PairModel(
      {this.index,
      this.name,
      this.uid,
      this.b,
      this.h,
      this.age,
      this.k,
      this.pin,
      this.gender,
      this.mobileNo,
      this.dName,
      this.dB,
      this.dH,
      this.dAge,
      this.dK,
      this.dPin,
      this.dGender,
      this.dMobileNo,
      this.priority,
      this.sPref,
      this.sd,
      this.masterFilter});

  void setPair(PairModel pair) {
    index = pair.getIndex();
    name = pair.getName();
    uid = pair.getUid();
    b = pair.getB();
    h = pair.getH();
    age = pair.getAge();
    k = pair.getK();
    pin = pair.getPin();
    mobileNo = pair.getMobileNo();
    gender = pair.getGender();
    dName = pair.getDName();
    dB = pair.getDB();
    dH = pair.getDH();
    dAge = pair.getDAge();
    dK = pair.getDK();
    dPin = pair.getDPin();
    dMobileNo = pair.getDMobileNo();
    dGender = pair.getDGender();
    priority = pair.getPriority();
    sPref = pair.getsPref();
    sd = pair.getSd();
    masterFilter = pair.getMasterFilter();
  }

  Map<String, dynamic> toJson() => {
        "Index": index,
        "UID": uid,
        "Name": name,
        "DName": dName,
        "MobileNo": mobileNo,
        "DMobileNo": dMobileNo,
        "Pincode": pin.toString(),
        "DPincode": dPin.toString(),
        "BloodGroup": b,
        "DBloodGroup": dB,
        "Gender": gender,
        "DGender": dGender,
        "SocietalDist": sd,
        "SdPref": sPref.toString(),
        "Priority": priority,
        "Age": age,
        "DAge": dAge,
        "KidneySize": k,
        "DKidneySize": dK,
        "Hla": h.toString(),
        "DHla": dH.toString(),
        "MasterFilter": masterFilter,
      };

  factory PairModel.fromJson(Map<String, dynamic> json1) {
    String name1 = json1['Name'];
    String dName1 = json1['DName'];
    String mobile = json1['MobileNo'];
    String dMobile = json1['DMobileNo'];
    String masterFilter = json1['MasterFilter'] ??
        ((name1 + dName1 + (mobile ?? "") + (dMobile ?? ""))
            .replaceAll(RegExp(r'\W+'), "")
            .toLowerCase());
    return PairModel(
        index: json1['Index'],
        name: name1,
        dName: dName1,
        mobileNo: mobile,
        dMobileNo: dMobile,
        uid: json1['UID'],
        b: json1['BloodGroup'],
        dB: json1['DBloodGroup'],
        pin: json1['Pincode'] != null
            ? int.parse(json1['Pincode'].toString())
            : null,
        dPin: json1['DPincode'] != null
            ? int.parse(json1['DPincode'].toString())
            : null,
        gender: json1['Gender'],
        dGender: json1['DGender'],
        sd: json1['SocietalDist'],
        h: json1['Hla'] != null ? json1['Hla'].toString().split(',') : [],
        sPref: json1['SdPref'] != null
            ? json1['SdPref'].toString().split(',')
            : [],
        dH: json1['DHla'] != null ? json1['DHla'].toString().split(',') : [],
        age: json1['Age'] != null ? int.parse(json1['Age']) : null,
        dAge: json1['DAge'] != null ? int.parse(json1['DAge']) : null,
        k: json1['KidneySize'] != null
            ? double.parse(json1['kidneySize'].toString())
            : null,
        dK: json1['DKidneySize'] != null
            ? double.parse(json1['dKidneySize'].toString())
            : null,
        priority:
            json1['Priority'] != null ? int.parse(json1['Priority']) : null,
        masterFilter: masterFilter);
  }
  PairModel copyClient() {
    return PairModel(
        index: index,
        name: name,
        uid: uid,
        b: b,
        h: h,
        age: age,
        k: k,
        pin: pin,
        mobileNo: mobileNo,
        gender: dGender,
        dName: dName,
        dB: dB,
        dH: dH,
        dAge: dAge,
        dK: dK,
        dPin: dPin,
        dMobileNo: dMobileNo,
        dGender: dGender,
        priority: priority,
        sPref: sPref,
        sd: sd,
        masterFilter: masterFilter);
  }

  int? getIndex() {
    return index;
  }

  void setIndex(int index) {
    this.index = index;
  }

  void setUid(String uid) {
    this.uid = uid;
  }

  String? getUid() {
    return uid;
  }

  String? getName() {
    return name;
  }

  String? getB() {
    return b;
  }

  List<String>? getH() {
    return h;
  }

  int? getAge() {
    return age;
  }

  double? getK() {
    return k;
  }

  int? getPin() {
    return pin;
  }

  String? getDName() {
    return dName;
  }

  String? getDMobileNo() {
    return dMobileNo;
  }

  String? getMobileNo() {
    return dMobileNo;
  }

  String? getGender() {
    return gender;
  }

  String? getDGender() {
    return dGender;
  }

  String? getDB() {
    return dB;
  }

  List<String>? getDH() {
    return dH;
  }

  int? getDAge() {
    return dAge;
  }

  double? getDK() {
    return dK;
  }

  int? getDPin() {
    return dPin;
  }

  int? getPriority() {
    return priority;
  }

  List<String>? getsPref() {
    return sPref;
  }

  String? getSd() {
    return sd;
  }

  String? getMasterFilter() {
    return masterFilter;
  }

  void setId(DatabaseReference id) {
    this.id = id;
  }
}
