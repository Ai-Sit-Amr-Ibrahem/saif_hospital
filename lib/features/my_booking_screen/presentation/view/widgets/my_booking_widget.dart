import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hisksa/features/my_booking_screen/data/model/my_booking_model.dart';
import 'package:hisksa/utils/resources/constants.dart';

import '../../../../../utils/resources/app_colors.dart';
import '../../../../../widgets/item_line.dart';
import '../my_booking_details_screen.dart';

class MyBookingWidget extends StatelessWidget {
  final Data data;
  const MyBookingWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, MyBookingDetailsScreen.routeName,);
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        elevation: 4,
        shadowColor: AppColors.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(
            AppConstants.pagePadding,
          ),
          child: Column(
            children: [
              ItemLine(
                icon: IconlyLight.password,
                text: data.rECEIPTHEADERID??'',
              ),
               ItemLine(
                icon: IconlyLight.calendar,
                text: 'ميعاد حجزك: ${data.dateVisit}',
              ),
               ItemLine(
                icon: IconlyLight.timeCircle,
                text: 'حجزك الساعة: ${data.dateVisit}',
              ),
              const Divider(endIndent: 50, thickness: 1),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      'https://cdn-dr-images.vezeeta.com/Assets/Images/SelfServiceDoctors/ENTb4490f/Profile/150/doctor-fazwy-babtain-neurology_20190630180131823.jpg',
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
                          text: data.dOCTORNAME??'',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        data.sPECIALIEST == 'NULL' ? const SizedBox() : ItemLine(
                          icon: IconlyBroken.category,
                          text: data.sPECIALIEST??'',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(endIndent: 50, thickness: 1),
               ItemLine(
                icon: Icons.history,
                text: 'حالة الحجز: ${data.sTATUS}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
