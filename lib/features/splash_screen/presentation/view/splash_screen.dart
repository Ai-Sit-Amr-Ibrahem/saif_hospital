import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hisksa/utils/firebase_notification/push_notification_service.dart';


import '../../../../utils/resources/app_assets.dart';
import '../../../../utils/resources/constants.dart';
import '../../../home_layout/presentation/view/home_layout.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/SplashScreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        splash: Image.asset(AppAssets.mainLogo),
        duration: 3000,
        centered: true,
        splashIconSize: 210,
        backgroundColor: isDark? Colors.black : Colors.white,
        nextScreen:  HomeLayout(),
      ),
    );
  }
}