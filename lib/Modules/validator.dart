import 'package:flutter/cupertino.dart';

String? validateName(String? value) {
  if (value!.isEmpty) return "required fields can't be left empty";
  return null;
}

String? validatePhoneNumber(
    String? value, TextEditingController phoneNumberTextField) {
  final phoneExp = RegExp(r'^\d\d\d\d\d\ \d\d\d\d\d$');
  if (value!.isNotEmpty && !phoneExp.hasMatch(value)) {
    return "Wrong Mobile No.!";
  } else if (value.isEmpty) {
    phoneNumberTextField.text = "";
  }
  return null;
}
