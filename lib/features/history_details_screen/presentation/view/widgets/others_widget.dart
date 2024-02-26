import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/history_details_screen/data/model/history_details_model.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/constants.dart';
import 'item_line_check_null.dart';


class OthersWidget extends StatelessWidget {
  final Data data;

  const OthersWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.otherServies!.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.pagePadding),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shadowColor: AppColors.mainColor,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.pagePadding,),
              child: ItemLineNullCheck(
                keyText: 'iTEMNAME',
                value: data.otherServies![index].iTEMNAME??'',
                icon: IconlyBroken.arrowLeft2,
              ),
            ),
          );
        });
  }
}