import 'package:flutter/material.dart';
import 'package:hisksa/utils/resources/app_fonts.dart';

import '../../../../../widgets/buttons.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const Text('رصيدك', style: AppFonts.headlineStyle,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('SAR', style: Theme.of(context).textTheme.bodySmall,),
            Text('550', style: Theme.of(context).textTheme.displayMedium,),

          ],
        ),
        const Text('سعر حجز الموعد', style: AppFonts.headlineStyle,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('SAR', style: Theme.of(context).textTheme.bodySmall,),
            Text('210', style: Theme.of(context).textTheme.displayMedium,),

          ],
        ),
        const SizedBox(height: 10,),
        StadiumButton(
            buttonWidth: double.infinity,
            title: 'اتمام الحجز', fct: (){},),
      ],
    );
  }
}
