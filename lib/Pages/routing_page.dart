import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../Models/register_index_model.dart';
import '../Modules/shared_preference_handler.dart';
import '../global_class.dart';
import '../Widgets/google_signin_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Modules/database.dart';
import '../custom_colors.dart';
import 'dashboard.dart';
import 'error_display_page.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({Key? key}) : super(key: key);

  @override
  _RoutingPageState createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  Future<Widget> getWidget() async {
    Widget? widget;
    // initiateDatabase();
    Connectivity connectivity = Connectivity();
    await connectivity.checkConnectivity().then((value) async => {
          if (value != ConnectivityResult.none)
            {
              GlobalClass.user = FirebaseAuth.instance.currentUser,
              if (GlobalClass.user != null)
                {
                  print(1),
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
                                  message:
                                      'Please contact System Administrator',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IKEP Buddy',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        darkTheme: darkThemeData,
        themeMode: ThemeMode.system,
        home: AnimatedSplashScreen.withScreenFunction(
          splash: 'assets/firebase_logo.png',
          screenFunction: getWidget,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: CustomColors.primaryColor,
          animationDuration: Duration(milliseconds: 1500),
          splashIconSize: double.maxFinite,
        ));
  }
}
