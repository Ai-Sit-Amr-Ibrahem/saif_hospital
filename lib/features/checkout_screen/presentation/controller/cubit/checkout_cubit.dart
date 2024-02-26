import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/checkout_screen/data/data_source/checkout_data_source.dart';
import 'package:hisksa/features/checkout_screen/data/repo/checkout_repo.dart';
import 'package:hisksa/features/home_layout/presentation/view/home_layout.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import '../../../../my_booking_screen/presentation/view/my_booking_screen.dart';
import 'checkout_states.dart';

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit() : super(CheckoutInitialState());

  static CheckoutCubit get(context) => BlocProvider.of(context);

  final CheckoutRepo _checkoutRepo = CheckoutRepo(
      networkInfo: instance<NetworkInfoImp>(),
      checkoutDataSource: CheckoutDataSource());

  void createAppointment(
      {required String timeId, required BuildContext context}) {
    Map<String, dynamic> body = {
      "RESOURCES_SCHEDULE_SLOTS_ID": timeId,
    };

    emit(CreateAppointmentLoadingState());
    showLoadingDialog(context, dismissible: false);
    _checkoutRepo.createAppointment(headers: {
      'Authorization' : HiveHelper.getToken(),
      'lang' : 'AR',
    }, body: body).then((value) {
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          error = 'لا يوجد اتصال بالانترنت';
          failSnackBar(
              'لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا', context);
        } else if (l is WrongDataFailure) {
          error = l.message.toString();

          failSnackBar(
              l.message.toString(), 'من فضلك ادخل بيانات صحيحة', context);
        } else if (l is ServerFailure) {
          error = 'هناك مشكلة في السيرفر ';

          failSnackBar('هناك مشكلة في السيرفر ',
              'برجاء التواصل مع خدمة العملاء', context);
        }
        dismissLoadingDialog(context);
        emit(CreateAppointmentLoadingState());
      }, (r) {
        dismissLoadingDialog(context);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'تم حجز الموعد بنجاح',
        ).then((value) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeLayout.routeName, (Route<dynamic> route) => false);
          Navigator.pushNamed(
            context,
            MyBookingScreen.routeName,
          );
        });
        emit(CreateAppointmentLoadingState());
      });
    });
  }
}
