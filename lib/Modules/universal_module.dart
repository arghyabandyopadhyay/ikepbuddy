import 'package:flutter/material.dart';

void globalShowInSnackBar(
    GlobalKey<ScaffoldMessengerState> messengerState, String content) {
  messengerState.currentState?.hideCurrentSnackBar();
  messengerState.currentState?.showSnackBar(SnackBar(content: Text(content)));
}
