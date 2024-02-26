import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/auth/presentation/features/login_screen/controller/login_cubit/login_cubit.dart';
import 'package:hisksa/features/auth/presentation/features/login_screen/controller/login_cubit/login_states.dart';
import 'package:hisksa/features/history_screen/presentation/view/history_screen.dart';
import 'package:hisksa/features/home_layout/presentation/controller/home_layout_state.dart';
import 'package:hisksa/features/profile_screen/presentation/view/widgets/contact_us_widget.dart';
import 'package:hisksa/features/receipt_screen/presentation/view/receipt_screen.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/buttons.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../../utils/helper/hive_helper.dart';
import '../../../../utils/resources/app_assets.dart';
import '../../../auth/presentation/features/forget_password/presentation/view/check_id_screen.dart';
import '../../../auth/presentation/features/forget_password/presentation/view/forget_password_screen.dart';
import '../../../auth/presentation/features/login_screen/presentation/view/login_screen.dart';
import '../../../balance/presentation/view/balance_screen.dart';
import '../../../home_layout/presentation/controller/home_layout_cubit.dart';
import '../../../my_booking_screen/presentation/view/my_booking_screen.dart';
import '../../../on_boarding_screen/presentation/view/on_boarding_screen.dart';
import '../controller/theme_cubit/theme_cubit.dart';
import '../controller/theme_cubit/theme_states.dart';
import 'widgets/profile_actions_widget.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HiveHelper.getToken() == ''
        ? Center(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.pagePadding,
                ),
              ),
              elevation: 4,
              shadowColor: AppColors.mainColor,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.pagePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'الرجاء تسجيل الدخول',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
                      builder: (context, state) {
                        return StadiumButton(
                          buttonWidth: double.infinity,
                          title: 'تسجيل الدخول',
                          fct: () {
                            HomeLayoutCubit.get(context).changeNavBarIndex(0);
                            Navigator.pushNamed(
                              context,
                              LoginScreen.routeName,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const ProfileHeader(),
                Padding(
                  padding: const EdgeInsets.all(AppConstants.pagePadding),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<ThemeCubit, ThemeStates>(
                              builder: (context, state) {
                                return ProfileButton(
                                    title: isDark ? 'نهاري' : 'ليلي',
                                    icon: Icons.brightness_4_outlined,
                                    color: isDark ? Colors.white : Colors.black,
                                    iconColor:
                                        Theme.of(context).bottomAppBarColor,
                                    iconSize: 25,
                                    fct: () {
                                      ThemeCubit.get(context).changeAppMode();
                                    });
                              },
                            ),
                          ),
                          Expanded(
                            child: ProfileButton(
                              title: '55 SAR',
                              icon: Ionicons.cash_outline,
                              color: const Color(0xff3eb82a),
                              iconColor: Colors.white,
                              iconSize: 28,
                              fct: () {},
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<ThemeCubit, ThemeStates>(
                              builder: (context, state) {
                                return ProfileButton(
                                    title: 'التاريخ المرضي',
                                    icon: Octicons.history,
                                    color: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: 25,
                                    fct: () {
                                      Navigator.pushNamed(
                                          context, HistoryScreen.routeName);
                                    });
                              },
                            ),
                          ),
                          Expanded(
                            child: ProfileButton(
                              title: 'تغيير كلمة السر',
                              icon: IconlyBroken.password,
                              color: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: 28,
                              fct: () {
                                Navigator.pushNamed(
                                  context,
                                  CheckIDScreen.routeName,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ProfileButton(
                              title: 'المواعيد المحجوزة مؤخراً',
                              icon: IconlyLight.calendar,
                              color: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: 28,
                              fct: () {
                                Navigator.pushNamed(
                                  context,
                                  MyBookingScreen.routeName,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: ProfileButton(
                              title: 'الفواتير',
                              icon: IconlyBroken.document,
                              color: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: 28,
                              fct: () {
                                Navigator.pushNamed(
                                  context,
                                  ReceiptScreen.routeName,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text(
                        'تواصل معنا',
                        style: AppFonts.headlineStyle,
                      ),
                      const ContactUsWidget(
                        fbLink: '',
                        twLink: '',
                        instagramLink: '',
                        phoneNumber: '',
                        whatsappNumber: '',
                        mapLink: '',
                        linkedLink: '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              'Version: ${packageInfo.version}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text('Copyright© ${DateTime.now().year}',
                                style: Theme.of(context).textTheme.caption),
                            Text(
                              'Powered By',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            InkWell(
                              onTap: () async {
                                String url = 'https://www.sitksa-eg.com/home';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              child: Image.asset(AppAssets.sitLogo, height: 55),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            BlocProvider<LoginCubit>(
                              create: (context) => LoginCubit(),
                              child: BlocBuilder<LoginCubit, LoginStates>(
                                  builder: (context, state) {
                                var cubit = LoginCubit.get(context);
                                return state is ClearFCMTokenLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          BlocBuilder<HomeLayoutCubit,
                                              HomeLayoutState>(
                                            builder: (context, state) {
                                              return StadiumButton(
                                                title: 'تسجيل الخروج',
                                                fct: () {
                                                  QuickAlert.show(
                                                    context: context,
                                                    type:
                                                        QuickAlertType.warning,
                                                    title: 'تسجيل الخروج !!',
                                                    text: 'ستقوم بتسجيل الخروج',
                                                    onConfirmBtnTap: () {
                                                      HomeLayoutCubit.get(
                                                              context)
                                                          .changeNavBarIndex(0);

                                                      cubit.clearFcmToken(
                                                          context);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.warning,
                                                title: 'تحذير',
                                                text:
                                                    'ستقوم بمسح حسابك وتفقد جميع بياناتك',
                                                onConfirmBtnTap: () {
                                                  cubit.clearFcmToken(context);
                                                },
                                              );
                                            },
                                            child: Text(
                                              'اضغط هنا لمسح الحساب',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                        ],
                                      );
                              }),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
