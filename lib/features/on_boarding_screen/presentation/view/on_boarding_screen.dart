import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:hisksa/features/home_layout/presentation/view/home_layout.dart';
import 'package:hisksa/utils/resources/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../../config.dart';
import '../../../../utils/resources/app_colors.dart';
import '../../../auth/presentation/features/login_screen/presentation/view/login_screen.dart';
import 'widgets/bottom_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = '/OnBoardingScreen';

  const OnBoardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonText: 'تسجيل الدخول',
        onFinish: () {
          Navigator.pushNamed(
            context,
            LoginScreen.routeName,
          );
        },
        skipTextButton: const Text(
          'تخطي',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              HomeLayout.routeName,
            );
          },
          child: const Text(
            'المواصلة كضيف',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.mainColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        trailingFunction: () {},
        controllerColor: AppColors.mainColor,
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        background: [
          Lottie.network(
            height: SizeConfig.height(400, context),

            AppDesign.onBoarding1Image,
            width: MediaQuery.of(context).size.width,
          ),
          Lottie.network(
            height: SizeConfig.height(400, context),

            AppDesign.onBoarding2Image,
            width: MediaQuery.of(context).size.width,
          ),
          Lottie.network(
            height: SizeConfig.height(400, context),

            AppDesign.onBoarding3Image,
            width: MediaQuery.of(context).size.width,
          ),
        ],
        speed: 1.8,
        pageBodies: const [
          BottomWidget(
            title: AppDesign.onBoarding1Title,
            subTitle: AppDesign.onBoarding1SubTitle,
          ),
          BottomWidget(
            title: AppDesign.onBoarding2Title,
            subTitle: AppDesign.onBoarding2SubTitle,
          ),
          BottomWidget(
            title: AppDesign.onBoarding3Title,
            subTitle: AppDesign.onBoarding3SubTitle,
          ),
        ],
      ),
    );
  }
}
