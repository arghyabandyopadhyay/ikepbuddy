import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikepbuddy/Pages/dashboard.dart';
import 'package:ikepbuddy/Pages/signin_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 100, bottom: 20),
      width: screenWidth,
      height: screenHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 121.44,
            height: 59.56,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                SizedBox(
                  width: 118.13,
                  height: 47.91,
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Color(0xff1b8f58),
                      fontSize: 36,
                      fontFamily: "Red Hat Display",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 0),
                SizedBox(
                  width: 45.26,
                  height: 11.65,
                  child: Text(
                    "to IKEP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: screenWidth * 0.9,
            height: 86,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 30.74,
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 0.34),
                Container(
                  height: 54.89,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xffe0dddd),
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: screenWidth * 0.9,
            height: 86,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  width: 151.27,
                  height: 30.86,
                  child: Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                Container(
                  height: 55.10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color(0xffe0dddd),
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            child: SizedBox(
              width: 199.82,
              height: 54.38,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 54.38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff1b8f58),
                    ),
                    padding: const EdgeInsets.only(
                      left: 60,
                      right: 49,
                      top: 10,
                      bottom: 17,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 27.19,
                          child: Text(
                            "Log In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (_) => DashboardPage(),
                )),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 12.95,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 11.65,
                  child: Text(
                    "forgot password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 12.95,
                  child: Text(
                    "Click here.",
                    style: TextStyle(
                      color: Color(0xff1b8f58),
                      fontSize: 11,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          SizedBox(
            width: screenWidth * 0.8,
            height: 34.96,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 124.75,
                  height: 12.95,
                  child: Text(
                    "Don’t have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
                const SizedBox(height: 9.06),
                GestureDetector(
                  child: const SizedBox(
                    width: 124.75,
                    height: 12.95,
                    child: Text(
                      "Sign in.",
                      style: TextStyle(
                        color: Color(0xff1b8f58),
                        fontSize: 11,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const SigninPage(),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
