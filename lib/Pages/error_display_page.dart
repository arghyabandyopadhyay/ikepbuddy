import '../Models/drawer_action_model.dart';
import '../Modules/auth.dart';
import '../Modules/universal_module.dart';
import 'routing_page.dart';
import '../global_class.dart';
import 'user_info_screen.dart';
import '../Widgets/drawer_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorDisplayPage extends StatefulWidget {
  final String? asset;
  final String? message;
  final String? appBarText;
  const ErrorDisplayPage({Key? key, this.asset, this.message, this.appBarText})
      : super(key: key);

  @override
  _ErrorDisplayPageState createState() => _ErrorDisplayPageState();
}

class _ErrorDisplayPageState extends State<ErrorDisplayPage> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.appBarText ?? ""),
          ),
          drawer: Drawer(
            child: DrawerContent(
              drawerItems: [
                DrawerActionModel(Icons.account_circle, "Profile", () async {
                  Navigator.pop(context);
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) =>
                          UserInfoScreen(mainScreenContext: context)));
                }),
                DrawerActionModel(Icons.logout, "Log out", () async {
                  await Authentication.signOut(context);
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        RoutingPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(-1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ));
                }),
              ],
            ),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/${widget.asset}'),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.message ?? "",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: const TextStyle(fontSize: 25),
              )
            ],
          )),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.appBarText == "Id Blocked")
                FloatingActionButton.extended(
                  heroTag: "contact_usButton",
                  onPressed: () async {
                    String url =
                        'mailto:<IKEP Buddybusinesssolutions@gmail.com>?subject=ID Blocked ${GlobalClass.userDetail != null ? GlobalClass.userDetail!.email : ""}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      globalShowInSnackBar(
                          scaffoldMessengerKey, 'Oops!! Something went wrong.');
                    }
                  },
                  icon: const Icon(Icons.contact_mail),
                  label: const Text("Contact Us"),
                ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton.extended(
                heroTag: "refreshButton",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (context) => RoutingPage()));
                },
                label: const Text("Refresh"),
                icon: const Icon(Icons.refresh),
              ),
            ],
          )),
      key: scaffoldMessengerKey,
    );
  }
}
