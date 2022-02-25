import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:ikepbuddy/Models/pair_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/token_model.dart';
import '../Pages/dashboard.dart';
import '../Pages/error_display_page.dart';
import '../Widgets/google_signin_button.dart';
import '../custom_colors.dart';
import '../global_class.dart';
import 'database.dart';
import 'shared_preference_handler.dart';

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

void changesSavedModule(BuildContext context,
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  currentFocus.unfocus();
  globalShowInSnackBar(scaffoldMessengerKey, "Changes have been saved");
}

deleteModule(PairModel clientData, BuildContext context, state) async {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("Confirm Delete"),
            content: Text(
                "Are you sure to delete ${clientData.name}?\n The change is irreversible."),
            actions: [
              ActionChip(
                  label: const Text("Yes"),
                  onPressed: () {
                    state.setState(() {
                      deleteDatabaseNode(clientData.id!);
                      Navigator.of(_).pop();
                      Navigator.of(context).pop(true);
                    });
                  }),
              ActionChip(
                  label: const Text("No"),
                  onPressed: () {
                    state.setState(() {
                      Navigator.of(_).pop();
                    });
                  })
            ],
          ));
}

List<PairModel> sortClientsModule(
    String sortType, List<PairModel> listToBeSorted) {
  List<PairModel> sortedList = [];
  if (sortType == "Age Ascending") {
    var temp = listToBeSorted.where((element) => element.age == null).toList();
    listToBeSorted.removeWhere((element) => element.age == null);
    listToBeSorted.sort((a, b) => a.age!.compareTo(b.age!));
    listToBeSorted.addAll(temp);
    sortedList = listToBeSorted;
  } else if (sortType == "Age Descending") {
    var temp = listToBeSorted.where((element) => element.age == null).toList();
    listToBeSorted.removeWhere((element) => element.age == null);
    listToBeSorted.sort((a, b) => b.age!.compareTo(a.age!));
    listToBeSorted.addAll(temp);
    sortedList = listToBeSorted;
  } else if (sortType == "Registration Id Ascending") {
    var temp = listToBeSorted
        .where((element) => element.uid == null || element.uid == "")
        .toList();
    listToBeSorted
        .removeWhere((element) => element.uid == null || element.uid == "");
    listToBeSorted
        .sort((a, b) => a.uid!.toLowerCase().compareTo(b.uid!.toLowerCase()));
    listToBeSorted.addAll(temp);
    sortedList = listToBeSorted;
  } else if (sortType == "Registration Id Descending") {
    var temp = listToBeSorted
        .where((element) => element.uid == null || element.uid == "")
        .toList();
    listToBeSorted
        .removeWhere((element) => element.uid == null || element.uid == "");
    listToBeSorted
        .sort((a, b) => b.uid!.toLowerCase().compareTo(a.uid!.toLowerCase()));
    listToBeSorted.addAll(temp);
    sortedList = listToBeSorted;
  } else if (sortType == "A-Z") {
    listToBeSorted
        .sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    sortedList = listToBeSorted;
  } else if (sortType == "Z-A") {
    listToBeSorted
        .sort((a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase()));
    sortedList = listToBeSorted;
  }
  return sortedList;
}

Future<void> sendRegisterAppEmail(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
    File pdfFile) async {
  String platformResponse;
  final MailOptions mailOptions = MailOptions(
    body:
        'Respected Sir, \nPlease register my account. My token is ${GlobalClass.user!.uid}',
    subject: 'Register IKEP Buddy ${GlobalClass.user!.email}',
    recipients: ['IKEP Buddybusinesssolutions@gmail.com'],
    isHTML: false,
    attachments: [
      pdfFile.path,
    ],
  );
  final MailerResponse response = await FlutterMailer.send(mailOptions);
  switch (response) {
    case MailerResponse.saved:

      /// ios only
      platformResponse = 'mail was saved to draft';
      break;
    case MailerResponse.sent:

      /// ios only
      platformResponse = 'mail was sent';
      break;
    case MailerResponse.cancelled:

      /// ios only
      platformResponse = 'mail was cancelled';
      break;
    case MailerResponse.android:
      platformResponse =
          'Registration Successful, Wait for the admin to grant access..';
      break;
    default:
      platformResponse = 'Something went wrong!!';
      break;
  }
  globalShowInSnackBar(scaffoldMessengerKey, platformResponse);
}

callModule(PairModel clientData,
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  if (clientData.mobileNo != null && clientData.mobileNo != "") {
    var url = 'tel:<${clientData.mobileNo}>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      globalShowInSnackBar(
          scaffoldMessengerKey, 'Oops!! Something went wrong.');
    }
  }
}

whatsAppModule(PairModel clientData,
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  if (clientData.mobileNo != null && clientData.mobileNo != "") {
    var url =
        "https://wa.me/+91${clientData.mobileNo}?text=${clientData.name}, ${GlobalClass.userDetail!.reminderMessage != null && GlobalClass.userDetail!.reminderMessage != "" ? GlobalClass.userDetail!.reminderMessage : "Your subscription has come to an end"
            ", please clear your dues for further continuation of services."}\npowered by IKEP Buddy Business Solutions";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      globalShowInSnackBar(
          scaffoldMessengerKey, 'Oops!! Something went wrong.');
    }
  } else {
    globalShowInSnackBar(scaffoldMessengerKey, "Please Enter Mobile No");
  }
}

smsModule(PairModel clientData,
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  if (clientData.mobileNo != null && clientData.mobileNo != "") {
    // SmsSender sender = new SmsSender();
    String? address = clientData.mobileNo;
    String message =
        "${clientData.name}, ${GlobalClass.userDetail!.reminderMessage != null && GlobalClass.userDetail!.reminderMessage != "" ? GlobalClass.userDetail!.reminderMessage : "Your subscription has come to an end"
            ", please clear your dues for further continuation of services."}\npowered by IKEP Buddy Business Solutions";
    if (address != null && address != "") {
      // sender.sendSms(new SmsMessage(address, message)).then((value) => globalShowInSnackBar(scaffoldMessengerKey,"Message has been sent to ${clientData.name}!!"));
      sendSMS(message: message, recipients: [address]).then((value) =>
          globalShowInSnackBar(scaffoldMessengerKey,
              "Message has been sent to ${clientData.name}!!"));
    }
  } else {
    globalShowInSnackBar(scaffoldMessengerKey, "No Mobile no present!!");
  }
}

void setToken(String? token) async {
  print(token);
  bool foundDeviceHistory = false;
  GlobalClass.user = FirebaseAuth.instance.currentUser;
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    GlobalClass.applicationToken = token;
    if (GlobalClass.user != null) {
      getUserDetails().then((value) => {
            if (value!.tokens == null)
              {
                addToken(
                    value,
                    TokenModel(
                        token: token,
                        deviceId: androidInfo.androidId,
                        deviceModel: androidInfo.model))
              }
            else
              {
                value.tokens!.forEach((element) {
                  if (element.deviceId == androidInfo.androidId) {
                    if (element.token != token) {
                      element.token = token;
                      updateToken(element);
                    }
                    foundDeviceHistory = true;
                  }
                }),
                if (!foundDeviceHistory)
                  addToken(
                      value,
                      TokenModel(
                          token: token,
                          deviceId: androidInfo.androidId,
                          deviceModel: androidInfo.model))
              },
          });
    }
  } else if (Platform.isIOS) {
    // request permissions if we're on android
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    GlobalClass.applicationToken = token;
    if (GlobalClass.user != null) {
      getUserDetails().then((value) => {
            if (value!.tokens == null)
              {
                addToken(
                    value,
                    TokenModel(
                        token: token,
                        deviceId: iosInfo.identifierForVendor,
                        deviceModel: iosInfo.model))
              }
            else
              {
                value.tokens!.forEach((element) {
                  if (element.deviceId == iosInfo.identifierForVendor) {
                    if (element.token != token) {
                      element.token = token;
                      updateToken(element);
                    }
                    foundDeviceHistory = true;
                  }
                }),
                if (!foundDeviceHistory)
                  addToken(
                      value,
                      TokenModel(
                          token: token,
                          deviceId: iosInfo.identifierForVendor,
                          deviceModel: iosInfo.model))
              },
          });
    }
  }
}

Future<Widget> getWidget(
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey) async {
  Widget? widget;
  // initiateDatabase();
  Connectivity connectivity = Connectivity();
  await connectivity.checkConnectivity().then((value) async => {
        if (value != ConnectivityResult.none)
          {
            GlobalClass.user = FirebaseAuth.instance.currentUser,
            if (GlobalClass.user != null)
              {
                await addUserDetail().then((value) async => {
                      if (value != null)
                        {
                          if (GlobalClass.userDetail!.isOwner == 1 ||
                              GlobalClass.userDetail!.isAppRegistered == 1)
                            await getLastRegister()
                                .then((lastRegister) async => {
                                      widget = MaterialApp(
                                          title: 'IKEP Buddy',
                                          debugShowCheckedModeBanner: false,
                                          theme: lightThemeData,
                                          darkTheme: darkThemeData,
                                          themeMode: ThemeMode.system,
                                          home: DashboardPage())
                                    })
                          else
                            {
                              widget = MaterialApp(
                                  title: 'IKEP Buddy',
                                  debugShowCheckedModeBanner: false,
                                  theme: lightThemeData,
                                  darkTheme: darkThemeData,
                                  themeMode: ThemeMode.system,
                                  home: DashboardPage())
                            }
                        }
                      else
                        {
                          widget = MaterialApp(
                              title: 'IKEP Buddy',
                              debugShowCheckedModeBanner: false,
                              theme: lightThemeData,
                              darkTheme: darkThemeData,
                              themeMode: ThemeMode.system,
                              home: const ErrorDisplayPage(
                                appBarText: "Id Blocked",
                                asset: "idBlocked.jpg",
                                message: 'Please contact System Administrator',
                              ))
                        }
                    })
              }
            else
              {
                widget = MaterialApp(
                    title: 'IKEP Buddy',
                    debugShowCheckedModeBanner: false,
                    theme: lightThemeData,
                    darkTheme: darkThemeData,
                    themeMode: ThemeMode.system,
                    home: ScaffoldMessenger(
                      key: scaffoldMessengerKey,
                      child: Scaffold(
                        body: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: 20.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Image.asset(
                                          'assets/firebase_logo.png',
                                          // height: 400,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Text(
                                      //   'IKEP Buddy',
                                      //   style: TextStyle(
                                      //     color: CustomColors.firebaseYellow,
                                      //     fontSize: 40,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   'Authentication',
                                      //   style: TextStyle(
                                      //     color: CustomColors.firebaseBlue,
                                      //     fontSize: 40,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                GoogleSignInButton(
                                  scaffoldMessengerKey: scaffoldMessengerKey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
              }
          }
        else
          {
            widget = MaterialApp(
                title: 'IKEP Buddy',
                debugShowCheckedModeBanner: false,
                theme: lightThemeData,
                darkTheme: darkThemeData,
                themeMode: ThemeMode.system,
                home: const ErrorDisplayPage(
                  appBarText: "No Internet Connection",
                  asset: "NoInternetError.webp",
                  message: 'Please connect to the Internet!!',
                ))
          }
      });
  return widget!;
}
