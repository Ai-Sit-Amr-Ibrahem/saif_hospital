import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/widgets/item_line.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/constants.dart';
import '../../../../../widgets/buttons.dart';
import 'package:hisksa/features/radio_lab_screen/data/model/radio_model.dart';

class RadioWidget extends StatelessWidget {
  final Data data;

  const RadioWidget({Key? key, required this.data}) : super(key: key);

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
            ItemLine(
                icon: Ionicons.barcode, text: 'كود الخدمة: ${data.iTEMCODE}'),
            ItemLine(
              icon: Fontisto.laboratory,
              text: 'اسم الخدمة: ${data.iTEMNAME}',
            ),
            ItemLine(
                icon: MaterialCommunityIcons.ticket_confirmation_outline,
                text: 'رقم التحليل: ${data.iTEMID}'),
            ItemLine(
                icon: MaterialCommunityIcons.family_tree,
                text: 'أصل التحليل (Parent Itemid): ${data.parentItem}'),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: StadiumButton(
                title: 'طباعة',
                fct: () async {
                  String url = data.llinkPreview!;
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
