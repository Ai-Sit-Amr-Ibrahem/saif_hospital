import 'package:flutter/material.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/size_config.dart';

class BottomWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const BottomWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.height(400, context),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.kDarkBlueColor,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
           SizedBox(
            height: SizeConfig.height(20, context),
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black26,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
