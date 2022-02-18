import 'package:flutter/material.dart';

class ErrorPageNoInternet extends StatelessWidget {
  const ErrorPageNoInternet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/NoInternetError.webp"),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Please connect to the Internet!!",
            textAlign: TextAlign.center,
            textScaleFactor: 1,
            style: TextStyle(fontSize: 17),
          )
        ],
      )),
    );
  }
}

class NoDataError extends StatelessWidget {
  const NoDataError({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/noData.jpg"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "No Data Found!!",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 17),
              )
            ],
          )),
    );
  }
}

class ErrorHasOccurred extends StatelessWidget {
  const ErrorHasOccurred({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/errorHasOccured.jpg"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "An Error Has Occurred!!",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 17),
              )
            ],
          )),
    );
  }
}
