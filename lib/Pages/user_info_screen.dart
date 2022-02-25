import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qr_code_tools/qr_code_tools.dart';
import 'dart:async';

import '../Models/pair_model.dart';
import '../Models/modal_option_model.dart';
import '../Models/user_model.dart';
import '../Modules/database.dart';
import '../Modules/universal_module.dart';
import '../Pages/help_and_feedback_page.dart';
import '../Modules/auth.dart';
import '../app_bar_variables.dart';
import '../custom_colors.dart';
import 'notifications_page.dart';
import 'qr_code_page.dart';
import 'routing_page.dart';
import '../global_class.dart';
import 'settings_page.dart';

class UserInfoScreen extends StatefulWidget {
  final BuildContext mainScreenContext;
  const UserInfoScreen({Key? key, required this.mainScreenContext})
      : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  bool _isSigningOut = false;
  bool isBackupOn = false;
  double progressValue = 0.0;
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  Route _routeToRoutingPage() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RoutingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
        child: Scaffold(
          appBar: AppBar(
            title: AppBarVariables.appBarLeading(widget.mainScreenContext),
            bottom: PreferredSize(
              child: (isBackupOn)
                  ? LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 2,
                    )
                  : const SizedBox(width: 0.0, height: 0.0),
              preferredSize: const Size(double.infinity, 2),
            ),
            actions: [
              if (GlobalClass.userDetail!.isAppRegistered == 1)
                IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      setState(() {
                        Navigator.of(widget.mainScreenContext).push(
                            CupertinoPageRoute(
                                builder: (notificationPageContext) =>
                                    const NotificationsPage()));
                      });
                    }),
              PopupMenuButton<ModalOptionModel>(
                itemBuilder: (BuildContext popupContext) {
                  return [
                    if (GlobalClass.userDetail!.isAppRegistered == 1 &&
                        GlobalClass.userDetail!.canAccess == 0)
                      ModalOptionModel(
                          particulars: "My Qr Code",
                          icon: Icons.qr_code_outlined,
                          onTap: () async {
                            Navigator.pop(popupContext);
                            UserModel? userModel = await getUserDetails();
                            if (userModel != null &&
                                userModel.qrcodeDetail != null) {
                              Navigator.of(widget.mainScreenContext).push(
                                  CupertinoPageRoute(
                                      builder: (qrCodePageContext) =>
                                          QrCodePage(
                                              qrCode:
                                                  userModel.qrcodeDetail!)));
                            } else if (userModel != null) {
                              String _data = '';
                              try {
                                final pickedFile = await ImagePicker().getImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 300,
                                  maxHeight: 300,
                                  imageQuality: 30,
                                );
                                setState(() {
                                  // QrCodeToolsPlugin.decodeFrom(pickedFile!.path)
                                  //     .then((value) {
                                  //   _data = value;
                                  //   userModel.qrcodeDetail = _data;
                                  //   userModel.update();
                                  // });
                                });
                              } catch (e) {
                                globalShowInSnackBar(
                                    scaffoldMessengerKey, "Invalid File!!");
                                setState(() {
                                  _data = '';
                                });
                              }
                            }
                          }),
                    ModalOptionModel(
                        particulars: "Help and Feedback",
                        icon: Icons.help_outline,
                        onTap: () async {
                          Navigator.pop(popupContext);
                          Navigator.of(widget.mainScreenContext).push(
                              CupertinoPageRoute(
                                  builder: (settingsContext) =>
                                      const HelpAndFeedbackPage()));
                        }),
                    ModalOptionModel(
                        particulars: "Settings",
                        icon: Icons.settings,
                        onTap: () async {
                          Navigator.pop(popupContext);
                          Navigator.of(widget.mainScreenContext).push(
                              CupertinoPageRoute(
                                  builder: (settingsContext) =>
                                      const SettingsPage()));
                        }),
                    // if (GlobalClass.user != null &&
                    //     GlobalClass.userDetail != null &&
                    //     GlobalClass.userDetail!.isOwner == 1)
                    //   ModalOptionModel(
                    //     particulars: "Dispatch Notification",
                    //     icon: Icons.send,
                    //     onTap: () async {
                    //       Navigator.of(popupContext).pop();
                    //       Navigator.of(widget.mainScreenContext).push(
                    //           CupertinoPageRoute(
                    //               builder: (context) =>
                    //                   DispatchNotificationConsole()));
                    //     },
                    //   ),
                    // if (GlobalClass.user != null &&
                    //     GlobalClass.userDetail! != null &&
                    //     GlobalClass.userDetail!.isOwner == 1)
                    //   ModalOptionModel(
                    //     particulars: "Users Access",
                    //     icon: Icons.account_box_outlined,
                    //     onTap: () async {
                    //       Navigator.of(context).pop();
                    //       Navigator.of(widget.mainScreenContext).push(
                    //           CupertinoPageRoute(
                    //               builder: (context) =>
                    //                   ClientAccessEditPage()));
                    //     },
                    //   ),
                  ].map((ModalOptionModel choice) {
                    return PopupMenuItem<ModalOptionModel>(
                      value: choice,
                      child: ListTile(
                        title: Text(choice.particulars),
                        leading: Icon(choice.icon, color: choice.iconColor),
                        onTap: choice.onTap,
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              children: [
                const SizedBox(height: 50.0),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  child: GlobalClass.user!.photoURL != null
                      ? ClipOval(
                          child: Material(
                            color: CustomColors.firebaseGrey.withOpacity(0.3),
                            child: Image.network(
                              GlobalClass.user!.photoURL!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        )
                      : ClipOval(
                          child: Material(
                            color: CustomColors.firebaseGrey.withOpacity(0.3),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: CustomColors.firebaseGrey,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  GlobalClass.user!.displayName!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${GlobalClass.user!.email}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 24.0),
                _isSigningOut
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isSigningOut = true;
                          });
                          await Authentication.signOut(context);
                          setState(() {
                            _isSigningOut = false;
                          });
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(widget.mainScreenContext)
                              .pushReplacement(_routeToRoutingPage());
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: const Text(
                            'Sign out',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                letterSpacing: 0.2),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
        key: scaffoldMessengerKey);
  }
}
