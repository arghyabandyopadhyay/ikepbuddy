import 'package:flutter/material.dart';
import 'package:ikepbuddy/Pages/login_page.dart';
import 'package:ikepbuddy/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: themeColor),
          scaffoldBackgroundColor: Colors.white,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: themeColor)),
      home: const LoginPage(),
    );
  }
}
