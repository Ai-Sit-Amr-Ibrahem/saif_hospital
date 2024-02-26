// 🎯 Dart imports:
import 'dart:convert';

// � Package imports:
// import 'package:bareeq/common/constants/enums.dart';
// import 'package:bareeq/features/main_screens/visits/presentation/update_visit/page/update_visit_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// �🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hisksa/utils/app/my_app.dart';


class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'default', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  final androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'default', 'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      icon: '@drawable/salam',
      playSound: true,
      showProgress: true,
      priority: Priority.high,
      ticker: '');

  final iOSChannelSpecifics = const DarwinNotificationDetails();
  late final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);

  
  Future<void> initNotifications() async {
    _initLocalNotification();
    await Future.wait([
      FirebaseMessaging.instance.requestPermission(provisional: true),
      _onMessageTerminated(),
    ]);

    _onMessageNotification();
    _onBackgroundMessageNotification();
    _onMessageOpened();
  }

  /// SHOW LOCAL NOTIFICATION WHILE IS APP IS IN FOREGROUND BECAUSE FIREBASE DOESN'T SUPPORT NOTIFICATIONS IN FOREGROUND
  _initLocalNotification() async {
    Future<void> onDidReceiveLocalNotification(
        int id, String? title, String? body, String? payload) {
      return showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => Directionality(
          textDirection: TextDirection.rtl,
          child: CupertinoAlertDialog(
            title: Text(title!),
            content: Text(body!),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Ok'),
                onPressed: () async {
                  _onSelectHandler(payload);
                },
              )
            ],
          ),
        ),
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/salam');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) =>
          _onSelectHandler(details.payload),
      onDidReceiveNotificationResponse: (details) =>
          _onSelectHandler(details.payload),
    );
  }

  Future _onSelectHandler(String? payload) async {
    // final Map decodedPayload = jsonDecode(payload ?? '');
    // decodedPayload['visit_status' ] = VisitStatus.wait_confirmation.name;
    // if (decodedPayload['visit_status'] == VisitStatus.wait_confirmation.name) {
    //   // Get.to(
    //   //   UpdateVisitsScreen(
    //   //     visitId: int.parse(decodedPayload['visit_id']),
    //   //     currentStatus: VisitStatus.wait_confirmation,
    //   //   ),
    //   // );
    // }
  }

  /// SHOW LOCAL NOTIFICATION WHILE IS APP IS IN FOREGROUND BECAUSE FIREBASE DOESN'T SUPPORT NOTIFICATIONS IN FOREGROUND
  void _onMessageNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _notificationHandler(message);
    });
  }

  Future _notificationHandler(RemoteMessage message) async {
    if (message.notification != null && message.data.isNotEmpty) {
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';
      _showNotification(title, body, message.data);
    }
  }

  void _onBackgroundMessageNotification() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _onMessageOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _onSelectHandler(jsonEncode(event.data));
    });
  }

  Future _onMessageTerminated() async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message == null) return;
    _onSelectHandler(jsonEncode(message.data));
  }

  _showNotification(String title, String body, Map payload) async {
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: jsonEncode(payload));
  }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
