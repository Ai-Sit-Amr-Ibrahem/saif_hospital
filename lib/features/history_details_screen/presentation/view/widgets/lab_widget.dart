import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/history_details_screen/data/model/history_details_model.dart';
import 'package:hisksa/features/history_details_screen/presentation/view/widgets/item_line_check_null.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';

class HistoryLabWidget extends StatelessWidget {
  final Data data;

  const HistoryLabWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:data.lABAROTYR!.length,
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
              child: Column(
                children: [
                  ItemLineNullCheck(
                    keyText: 'ITEM_ID',
                    value: data.lABAROTYR![index].iTEMNAME ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'ITEM_CODE',
                    value: data.lABAROTYR![index].iTEMCODE ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'iTEMID',
                    value: data.lABAROTYR![index].iTEMID ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'pARENTITEM',
                    value: data.lABAROTYR![index].pARENTITEM ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                ],
              ),
            ),
          );
        });
  }
}