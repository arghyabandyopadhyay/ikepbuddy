import 'package:flutter/material.dart';

class AppBarVariables {
  static final List<Widget> aboutBoxChildren = <Widget>[
    const SizedBox(height: 24),
    const Text('IKEP Buddy is an easy to go Register maintaining application. '
        'It is capable of managing your registers and maintaining '
        'the fee records of your clients. '),
  ];

  static Widget appBarLeading(appBarLeading) => Row(
        children: [
          GestureDetector(
              onTap: () {
                showAboutDialog(
                  context: appBarLeading,
                  applicationIcon: Image.asset(
                    "assets/icon.png",
                    width: 40,
                    height: 40,
                  ),
                  applicationName: 'IKEP Buddy',
                  applicationVersion: 'Version 2021.2',
                  applicationLegalese:
                      '\u{a9} 2021 IKEP Buddy Business Solutions',
                  children: AppBarVariables.aboutBoxChildren,
                );
              },
              child: Image.asset(
                "assets/icon.png",
                height: 25,
                width: 25,
              )),
          const Text(" IKEP Buddy")
        ],
      );
}
