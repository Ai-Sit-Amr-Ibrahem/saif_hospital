import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/animated_image.dart';
import 'package:hisksa/widgets/item_line.dart';

import '../../../../../utils/helper/hive_helper.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          const SizedBox(
            height: 280,
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppConstants.pagePadding),
                  bottomRight: Radius.circular(AppConstants.pagePadding),
                ),
              ),
              shadowColor: AppColors.mainColor,
              elevation: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: AnimatedImage(
                  imageUrl:
                      'https://img.freepik.com/premium-photo/doctor-with-stethoscope-hand-hospital-background_34200-156.jpg?w=900'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.pagePadding)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: AppColors.mainColor,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.pagePadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ItemLine(icon: IconlyBroken.profile, text: HiveHelper.getUserData()!.data!.userdata!.uSERNAME??''),
                      ItemLine(icon: IconlyBroken.call, text: HiveHelper.getUserData()!.data!.userdata!.tELEPHONE??''),
                      ItemLine(icon: IconlyBroken.calendar, text: 'Age: 22'),
                      ItemLine(icon: Fontisto.money_symbol, text: '55 SAR'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
