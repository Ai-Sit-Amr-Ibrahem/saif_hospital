import 'package:flutter/material.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';

import '../../../../../utils/resources/app_fonts.dart';

class CenterHeaderWidget extends StatelessWidget {
  const CenterHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppConstants.pagePadding,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: AppColors.mainColor,
      elevation: 4,
      child: Row(
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://cdn-dr-images.vezeeta.com/Assets/Images/Entities/ent11714da91fcb536b/Facilities/beverly-clinics-by-saudi-german-health--al-khalidiyyah-jeddah_20221002084919961.jpg',
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            'مركز عيادات بيفرلي عضو السعودي الألماني الصحيه',
            style: AppFonts.headlineStyle,
          ))
        ],
      ),
    );
  }
}
