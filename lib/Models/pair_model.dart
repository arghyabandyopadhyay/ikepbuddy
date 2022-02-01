// import 'package:firebase_database/firebase_database.dart';

class PairModel {
  // DatabaseReference id;
  String? name;
  String? registrationId;
  String? fathersName;
  String? education;
  String? occupation;
  String? address;
  String? injuries;
  String? sex;
  String? caste;
  String? mobileNo;
  String? masterFilter;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? dob;
  DateTime? joiningDate;
  double? height;
  double? weight;
  int? lastInvoiceNo;
  int? due;
  bool? isSelected = false;
  PairModel(
      {this.registrationId,
      this.name,
      this.lastInvoiceNo,
      this.sex,
      this.caste,
      this.joiningDate,
      this.mobileNo,
      this.fathersName,
      this.education,
      this.occupation,
      this.address,
      this.injuries,
      this.startDate,
      this.endDate,
      this.height,
      this.dob,
      this.weight,
      this.due,
      this.masterFilter});
  // void setId(DatabaseReference id)
  // {
  //   this.id=id;
  // }
  factory PairModel.fromJson(Map<String, dynamic> json1) {
    String startDate = json1['StartDate'];
    String endDate = json1['EndDate'];
    String name = json1['Name'];
    String mobile = json1['MobileNo'];
    String masterFilter = json1['MasterFilter'] ??
        ((name + (mobile ?? "") + (startDate ?? "") + (endDate ?? ""))
            .replaceAll(RegExp(r'\W+'), "")
            .toLowerCase());
    return PairModel(
        registrationId: json1['RegistrationId'],
        name: name,
        fathersName: json1['FathersName'],
        mobileNo: mobile,
        education: json1['Education'],
        occupation: json1['Occupation'],
        address: json1['Address'],
        injuries: json1['Injuries'],
        sex: json1['Sex'],
        caste: json1['Caste'],
        startDate: DateTime.parse(startDate),
        endDate: DateTime.parse(endDate),
        dob: json1['Dob'] != null ? DateTime.parse(json1['Dob']) : null,
        joiningDate: json1['JoiningDate'] != null
            ? DateTime.parse(json1['JoiningDate'])
            : null,
        height: json1['Height'] != null
            ? double.parse(json1['Height'].toString())
            : null,
        weight: json1['Weight'] != null
            ? double.parse(json1['Weight'].toString())
            : null,
        due: json1['Due'] ?? 0,
        lastInvoiceNo: json1['LastInvoiceNumber'] ?? 0,
        masterFilter: masterFilter);
  }
  PairModel copyClient() {
    return PairModel(
        registrationId: registrationId,
        name: name,
        fathersName: fathersName,
        mobileNo: mobileNo,
        education: education,
        occupation: occupation,
        address: address,
        injuries: injuries,
        sex: sex,
        caste: caste,
        startDate: startDate,
        endDate: endDate,
        dob: dob,
        joiningDate: joiningDate,
        height: height,
        weight: weight,
        due: due,
        lastInvoiceNo: lastInvoiceNo,
        masterFilter: masterFilter);
  }

  Map<String, dynamic> toJson() => {
        "RegistrationId": registrationId,
        "Name": name,
        "FathersName": fathersName,
        "MobileNo": mobileNo,
        "Education": education,
        "Occupation": occupation,
        "Address": address,
        "Injuries": injuries,
        "Sex": sex,
        "StartDate": (startDate != null) ? startDate!.toIso8601String() : null,
        "EndDate": (endDate != null) ? endDate!.toIso8601String() : null,
        "Caste": caste,
        "Dob": (dob != null) ? dob!.toIso8601String() : null,
        "JoiningDate":
            (joiningDate != null) ? joiningDate!.toIso8601String() : null,
        "Height": height,
        "Weight": weight,
        "Due": due,
        "LastInvoiceNumber": lastInvoiceNo,
        "MasterFilter": masterFilter,
      };
}
