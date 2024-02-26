import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/features/history_details_screen/data/model/history_details_model.dart';
import 'package:hisksa/features/history_details_screen/presentation/view/widgets/item_line_check_null.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';

class VisitDataWidget extends StatelessWidget {
  final Data data;

  const VisitDataWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:data.visitData!.length,
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
                    keyText: 'MD_EN_NAME',
                    value: data.visitData![index].mDENNAME??'',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'COMMINT',
                    value: data.visitData![index].cOMMINT ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'OUTO_COMMINT',
                    value: data.visitData![index].oUTOCOMMINT ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'COMMINT',
                    value: data.visitData![index].cOMMINT ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                  ItemLineNullCheck(
                    keyText: 'NAME_MEDICATION',
                    value: data.visitData![index].nAMEMEDICATION ?? '',
                    icon: IconlyBroken.arrowLeft2,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
