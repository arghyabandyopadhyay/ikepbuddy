import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikepbuddy/Pages/login_page.dart';
import 'package:ikepbuddy/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'Models/token_model.dart';
import 'Modules/database.dart';
import 'Modules/auth.dart';
import 'Pages/error_display_page.dart';
import 'Pages/notifications_page.dart';
import 'Models/received_notification_model.dart';
import 'Pages/routing_page.dart';
import 'custom_colors.dart';
import 'global_class.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
String? selectedNotificationPayload;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotificationModel>
    didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotificationModel>();
final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/notificationicon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification:
              (int id, String? title, String? body, String? payload) async {
            didReceiveLocalNotificationSubject.add(ReceivedNotificationModel(
                id: id, title: title, body: body, payload: payload));
          });
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) {
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload!);
  });
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const IkepBuddy());
}

class IkepBuddy extends StatefulWidget {
  const IkepBuddy({Key? key}) : super(key: key);
  @override
  _IkepBuddyState createState() => _IkepBuddyState();
}

class _IkepBuddyState extends State<IkepBuddy> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "navigator");
  Stream<String>? _tokenStream;
  void setToken(String? token) async {
    bool foundDeviceHistory = false;
    GlobalClass.user = FirebaseAuth.instance.currentUser;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      GlobalClass.applicationToken = token;
      if (GlobalClass.user != null) {
        getUserDetails().then((value) => {
              if (value.tokens == null)
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
              if (value.tokens == null)
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

  Future<void> requestPermissions() async {
    // NotificationSettings settings =
    await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotificationModel receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                navigatorKey.currentState!.push(CupertinoPageRoute(
                    builder: (context) => NotificationsPage()));
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      navigatorKey.currentState!
          .push(CupertinoPageRoute(builder: (context) => NotificationsPage()));
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        navigatorKey.currentState?.push(
            CupertinoPageRoute(builder: (context) => NotificationsPage()));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: '@drawable/notificationicon',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState
          ?.push(CupertinoPageRoute(builder: (context) => NotificationsPage()));
    });
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream?.listen(setToken);
    requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   theme: ThemeData(
    //       appBarTheme: AppBarTheme(backgroundColor: themeColor),
    //       scaffoldBackgroundColor: Colors.white,
    //       colorScheme:
    //           ColorScheme.fromSwatch().copyWith(secondary: themeColor)),
    //   home: const LoginPage(),
    // );
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'IkepBuddy',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        darkTheme: darkThemeData,
        themeMode: ThemeMode.system,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomColors.primaryColor,
          body: FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorDisplayPage(
                    appBarText: "Error 404",
                    asset: "errorHasOccured.jpg",
                    message: 'Please contact System Administrator',
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return RoutingPage();
                }
                return Container(height: 0, width: 0);
              }),
        ));
  }
}
