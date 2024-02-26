import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/my_booking_screen/data/data_source/my_booking_data_source.dart';
import 'package:hisksa/features/my_booking_screen/data/model/my_booking_model.dart';
import 'package:hisksa/features/my_booking_screen/data/repo/my_booking_repo.dart';
import 'package:hisksa/features/my_booking_screen/presentation/controller/cubit/my_booking_states.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';

class MyBookingCubit extends Cubit<MyBookingStates> {
  MyBookingCubit() : super(MyBookingInitialState());

  static MyBookingCubit get(context) => BlocProvider.of(context);

  final MyBookingRepo _myBookingRepo = MyBookingRepo(
    networkInfo: instance<NetworkInfoImp>(),
    myBookingDataSource: MyBookingDataSource(),
  );

  MyBookingModel? myBookingModel;

  void getMyBooking(context) {
    print('ttt');
    emit(GetMyBookingLoadingState());
    _myBookingRepo.getMyBooking(
        headers: {
          'Authorization': HiveHelper.getToken(),
        }
    ).then((value) {
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

          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء',
              context);
        }
        emit(GetMyBookingErrorState());
      }, (r) {
        myBookingModel = r;
        emit(GetMyBookingSuccessState(),);
      });
    });
  }

}