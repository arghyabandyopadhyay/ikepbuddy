import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ikepbuddy/Models/pair_model.dart';

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

String generateMasterFilter(PairModel client) {
  return (client.name! +
          (client.mobileNo ?? "") +
          (client.uid ?? (client.id != null ? client.id!.key! : "")))
      .replaceAll(RegExp(r'\W+'), "")
      .toLowerCase();
}

List<PairModel> sortClientsModule(
    String sortType, List<PairModel> listToBeSorted) {
  List<PairModel> sortedList = [];
  if (sortType == "Dues First") {
    List<PairModel> temp =
        listToBeSorted.where((element) => element.due > 0).toList();
    sortedList.addAll(temp);
    temp = listToBeSorted.where((element) => element.due <= 0).toList();
    sortedList.addAll(temp);
  } else if (sortType == "Last Months First") {
    List<PairModel> temp =
        listToBeSorted.where((element) => element.due == 0).toList();
    sortedList.addAll(temp);
    temp = listToBeSorted.where((element) => element.due != 0).toList();
    sortedList.addAll(temp);
  } else if (sortType == "Registration Id Ascending") {
    var temp = listToBeSorted
        .where((element) =>
            element.registrationId == null || element.registrationId == "")
        .toList();
    listToBeSorted.removeWhere((element) =>
        element.registrationId == null || element.registrationId == "");
    listToBeSorted.sort((a, b) => a.registrationId
        .toLowerCase()
        .compareTo(b.registrationId.toLowerCase()));
    listToBeSorted.addAll(temp);
    sortedList = listToBeSorted;
  } else if (sortType == "Registration Id Descending") {
    var temp = listToBeSorted
        .where((element) =>
            element.registrationId == null || element.registrationId == "")
        .toList();
    listToBeSorted.removeWhere((element) =>
        element.registrationId == null || element.registrationId == "");
    listToBeSorted.sort((a, b) => b.registrationId
        .toLowerCase()
        .compareTo(a.registrationId.toLowerCase()));
    listToBeSorted.addAll(temp);
    sortedList = listToBeSorted;
  } else if (sortType == "Paid First") {
    List<PairModel> temp =
        listToBeSorted.where((element) => element.due < 0).toList();
    sortedList.addAll(temp);
    temp = listToBeSorted.where((element) => element.due >= 0).toList();
    sortedList.addAll(temp);
  } else if (sortType == "A-Z") {
    listToBeSorted
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    sortedList = listToBeSorted;
  } else if (sortType == "Z-A") {
    listToBeSorted
        .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    sortedList = listToBeSorted;
  } else if (sortType == "Start Date Ascending") {
    listToBeSorted.sort((a, b) =>
        a.startDate.toIso8601String().compareTo(b.startDate.toIso8601String()));
    sortedList = listToBeSorted;
  } else if (sortType == "Start Date Descending") {
    listToBeSorted.sort((a, b) =>
        b.startDate.toIso8601String().compareTo(a.startDate.toIso8601String()));
    sortedList = listToBeSorted;
  } else if (sortType == "End Date Ascending") {
    listToBeSorted.sort((a, b) =>
        a.endDate.toIso8601String().compareTo(b.endDate.toIso8601String()));
    sortedList = listToBeSorted;
  } else if (sortType == "End Date Descending") {
    listToBeSorted.sort((a, b) =>
        b.endDate.toIso8601String().compareTo(a.endDate.toIso8601String()));
    sortedList = listToBeSorted;
  }
  return sortedList;
}
