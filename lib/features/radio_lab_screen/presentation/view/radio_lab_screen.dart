import 'package:flutter/material.dart';
import 'package:hisksa/features/auth/presentation/features/login_screen/presentation/view/login_screen.dart';
import 'package:hisksa/features/radio_lab_screen/presentation/view/radio_screen.dart';
import 'package:hisksa/utils/helper/hive_helper.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/buttons.dart';

import 'lab_screen.dart';

class RadioAndLabScreen extends StatelessWidget {
  const RadioAndLabScreen({Key? key}) : super(key: key);

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
                      'لعرض التحاليل والأشعة الخاصة بكم الرجاء تسجيل الدخول',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StadiumButton(
                      buttonWidth: double.infinity,
                      title: 'تسجيل الدخول',
                      fct: () {
                        Navigator.pushNamed(
                          context,
                          LoginScreen.routeName,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('نتائج الفحوصات'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'معمل'),
                    Tab(text: 'أشعة'),
                  ],
                ),
              ),
              body: const TabBarView(children: [
                LabScreen(),
                RadioScreen(),
              ]),
            ),
          );
  }
}
