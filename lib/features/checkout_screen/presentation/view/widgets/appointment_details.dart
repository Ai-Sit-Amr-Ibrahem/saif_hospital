import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../utils/resources/app_fonts.dart';
import '../../../../../utils/resources/constants.dart';
import '../../../../../widgets/item_line.dart';
import '../../../../dates_screen/data/model/dates_model.dart';
import '../../../../doctors_screen/data/model/doctor_Model.dart';
import '../../../../times_screen/data/model/time_model.dart';

class AppointmentDetails extends StatelessWidget {
  final DoctorData doctorData;
  final Data date;
  final TimeData time;

  const AppointmentDetails({
    Key? key,
    required this.doctorData,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      elevation: 8,
      shadowColor: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'معلومات الطبيب',
              style: AppFonts.headlineStyle,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                    doctorData.dOCTORIMAGE != 'Null' ||
                            doctorData.dOCTORIMAGE == null
                        ? doctorData.dOCTORIMAGE!
                        : 'https://cdn-dr-images.vezeeta.com/Assets/Images/SelfServiceDoctors/ENTb4490f/Profile/150/doctor-fazwy-babtain-neurology_20190630180131823.jpg',
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
                        text: doctorData.dOCTORNAME ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.mainColor),
                      ),
                      ItemLine(
                        icon: IconlyBroken.category,
                        text: doctorData.dOCTORDEGRE ?? '',
                      ),
                      ItemLine(
                        icon: IconlyBroken.ticket,
                        text: '${formatter.format(doctorData.price)} SAR',
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              endIndent: 50,
              thickness: 1,
            ),
            const Text(
              'الموعد المحدد',
              style: AppFonts.headlineStyle,
            ),
            ItemLine(
              icon: IconlyBroken.calendar,
              text: date.dATESCHADUALE!,
            ),
            ItemLine(
              icon: IconlyBroken.timeCircle,
              text: time.tIMEAVILABLE!,
            ),
          ],
        ),
      ),
    );
  }
}
