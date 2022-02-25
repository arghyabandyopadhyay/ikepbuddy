import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../Modules/universal_module.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../custom_colors.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({Key? key}) : super(key: key);

  @override
  _RoutingPageState createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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
          screenFunction: () async {
            return await getWidget(scaffoldMessengerKey);
          },
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: CustomColors.primaryColor,
          animationDuration: const Duration(milliseconds: 1500),
          splashIconSize: double.maxFinite,
        ));
  }
}
