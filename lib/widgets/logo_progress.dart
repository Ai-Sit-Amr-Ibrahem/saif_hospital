import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config.dart';

class LogoProgress extends StatelessWidget {
  const LogoProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppDesign.logoProgress,
        height: 200,
      ),
    );
  }
}
