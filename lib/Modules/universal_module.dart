import 'dart:convert';

import 'package:flutter/material.dart';

void globalShowInSnackBar(
    GlobalKey<ScaffoldMessengerState> messengerState, String content) {
  messengerState.currentState?.hideCurrentSnackBar();
  messengerState.currentState?.showSnackBar(SnackBar(content: Text(content)));
}

String encrypt(String password) {
  String encryptedPassword = "";
  List<int> encode = utf8.encode(password);
  encryptedPassword = base64Encode(encode);
  return encryptedPassword;
}
