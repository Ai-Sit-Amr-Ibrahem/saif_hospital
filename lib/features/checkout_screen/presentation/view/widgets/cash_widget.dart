import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hisksa/utils/app/my_app.dart';

import '../../../../../widgets/buttons.dart';
import '../../../../auth/presentation/widgets/input_field.dart';
import '../../../../times_screen/data/model/time_model.dart';
import '../../controller/cubit/checkout_cubit.dart';

class CashWidget extends StatelessWidget {
  final TimeData time;
  final CheckoutCubit cubit;

  const CashWidget({Key? key, required this.time, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
            'الرجاء العلم انه في حالة اختيار الدفع كاش يتم الحضور قبل ميعادك المحدد بساعة لتأكيد الحجز والدفع'),
        const SizedBox(
          height: 10,
        ),
         StadiumButton(
            buttonWidth: double.infinity,
            title: 'اتمام الحجز',
            fct: () {
              cubit.createAppointment(
                timeId: time.rESOURCESSCHEDULESLOTSID.toString(),
                context: navigatorKey.currentState!.context,
              );
            }),
      ],
    );
  }
}
