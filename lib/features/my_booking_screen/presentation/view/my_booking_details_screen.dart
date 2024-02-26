import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../utils/resources/app_colors.dart';
import '../../../../utils/resources/constants.dart';
import '../../../../widgets/item_line.dart';

class MyBookingDetailsScreen extends StatelessWidget {
  static const routeName = '/MyBookingDetailsScreen';

  const MyBookingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dr/ Mohamed Salah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.pagePadding),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const ItemLine(
                  icon: IconlyLight.calendar,
                  text: 'ميعاد حجزك: 12/3/2015',
                ),
                const ItemLine(
                  icon: IconlyLight.timeCircle,
                  text: 'حجزك الساعة: 9:30am',
                ),
                ItemLine(
                  icon: IconlyLight.calendar,
                  text: 'تم الحجز في: 8/3/2015',
                  style: Theme.of(context).textTheme.bodySmall,
                  iconColor: Colors.grey,
                ),
                const Divider(
                  endIndent: 50,
                  thickness: 1,
                ),
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
                            text: 'Dr Mohamed Beh',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: AppColors.mainColor),
                          ),
                          const ItemLine(
                            icon: IconlyBroken.category,
                            text: 'دكتوراه في الأمراض الباطنية',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(endIndent: 50, thickness: 1),
                const ItemLine(
                  icon: Icons.history,
                  text: 'حالة الحجز: تحت الطلب',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
