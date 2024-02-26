import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/radio_lab_screen/data/model/lab_model.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/utils/resources/constants.dart';
import 'package:hisksa/widgets/buttons.dart';
import 'package:hisksa/widgets/item_line.dart';
import 'package:url_launcher/url_launcher.dart';

class LabWidget extends StatelessWidget {
  final Data data;
  const LabWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.pagePadding),
      ),
      elevation: 4,
      shadowColor: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
        child: Column(
          children: [
            ItemLine(icon: Ionicons.barcode, text: 'كود الخدمة: ${data.iTEMCODE}'),
            ItemLine(icon: Fontisto.laboratory, text: 'اسم الخدمة: ${data.iTEMNAME}'),
            ItemLine(icon: MaterialCommunityIcons.ticket_confirmation_outline, text: 'رقم التحليل: ${data.iTEMID}'),
            ItemLine(icon: MaterialCommunityIcons.family_tree, text: 'أصل التحليل (Parent Itemid): ${data.pARENTITEM}'),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: StadiumButton(
                title: 'طباعة',
                fct: () async {
                  String url = data.linkPreview!;
                  if (await canLaunch(url)) {
                  await launch(url);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
