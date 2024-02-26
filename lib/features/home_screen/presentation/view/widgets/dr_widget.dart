import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/dates_screen/presentation/view/dates_screen.dart';
import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';
import 'package:hisksa/utils/resources/app_colors.dart';
import 'package:hisksa/widgets/cached_image.dart';
import 'package:hisksa/widgets/item_line.dart';

import '../../../../../utils/resources/constants.dart';

class DrWidget extends StatelessWidget {
  final DoctorData data;

  const DrWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DatesScreen.routeName, arguments: data);
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        elevation: 8,
        shadowColor: AppColors.mainColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: const CircleBorder(),
                    elevation: 4,
                    shadowColor: AppColors.mainColor,
                    child: CachedImageWidget(
                      image: data.dOCTORIMAGE != 'NULL'
                          ? data.dOCTORNAME!
                          : 'https://img.freepik.com/free-photo/medical-banner-with-doctor-wearing-goggles_23-2149611193.jpg?w=900&t=st=1680166194~exp=1680166794~hmac=fdc7357426a297dce81d20b4bf2e0a2a47ceaf4d70b3fd70ddabc5b7175fd779',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        ItemLine(
                          icon: Fontisto.stethoscope,
                          text: data.dOCTORNAME ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        ItemLine(
                          icon: IconlyBroken.category,
                          text: data.dOCTORDEGRE ?? '',
                        ),
                        data.price == 0
                            ? const SizedBox()
                            : ItemLine(
                                icon: IconlyBroken.ticket,
                                text: '${formatter.format(data.price)} SAR'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
