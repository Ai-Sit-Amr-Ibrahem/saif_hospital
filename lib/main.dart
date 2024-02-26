import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/utils/di/injection.dart';
import 'package:hisksa/utils/firebase_notification/push_notification_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';
import 'utils/app/my_app.dart';
import 'utils/bloc_obsever/bloc_observer.dart';
import 'utils/helper/hive_helper.dart';
import 'utils/helper/theme_pref.dart';

late PackageInfo packageInfo;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await PushNotificationService().initNotifications();

  await CacheHelper.init();
  await initAppInjection();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.boxKeyUserData);
  await Hive.openBox(HiveHelper.userToken);
  Bloc.observer = MyBlocObserver();
  packageInfo = await PackageInfo.fromPlatform();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),);
}