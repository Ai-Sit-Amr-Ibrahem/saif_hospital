import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/constants.dart';
import '../../../../../widgets/item_line.dart';
import 'package:hisksa/features/receipt_screen/data/model/bills_model.dart';

class ReceiptWidget extends StatelessWidget {
  final Data data;
  const ReceiptWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.pagePadding,),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      shadowColor: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
        child: Column(
          children:  [
            ItemLine(icon: IconlyBroken.arrowLeft2,label: 'النوع', text: data.inOut??''),
            ItemLine(icon: IconlyBroken.timeCircle,label: 'الموعد', text: timeFormat.format(DateTime.parse(data.rECEIPTDATE.toString()))),
            ItemLine(icon: IconlyBroken.calendar,label: 'اليوم', text: format.format(DateTime.parse(data.rECEIPTDATE.toString()))),
            ItemLine(icon: Fontisto.stethoscope,label: 'الطبيب', text: data.doctor??''),
            ItemLine(icon: IconlyBroken.category, label: 'تخصص الطبيب ', text: data.specialist??'',),
            ItemLine(icon: IconlyBroken.arrowLeft2, label: 'طريقة الدفع', text: data.fINANCIALCATEGORIES??'',),
            ItemLine(icon: IconlyBroken.arrowLeft2, label: 'السعر', text: data.gROSSAMOUNT.toString(),),
            ItemLine(icon: IconlyBroken.arrowLeft2, label: 'قيمة الخصم', text: data.dISCOUNTAMOUNT.toString(),),
            ItemLine(icon: IconlyBroken.arrowLeft2, label: 'السعر الكلي', text: data.pATIENTAMOUNT.toString(),),
            const SizedBox(height: 5,),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: StadiumButton(
                fct: () async {
                  String url = data.lINKPREVIEW!;
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                title: 'طباعة الفاتورة',
              ),
            )
          ],
        ),
      ),
    );
  }
}
