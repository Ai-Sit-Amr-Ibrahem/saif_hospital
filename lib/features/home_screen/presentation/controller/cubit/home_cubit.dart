import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';
import 'package:hisksa/features/home_screen/data/data_source/home_data_source.dart';
import 'package:hisksa/features/home_screen/data/repo/home_repo.dart';
import 'package:hisksa/features/home_screen/presentation/controller/cubit/home_states.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final HomeRepo _homeRepo = HomeRepo(
    networkInfo: instance<NetworkInfoImp>(),
    homeDataSource: HomeDataSource(),
  );

  DoctorModel? doctorModel;

  void getAvailableDoctors(context) {
    print('ttt');
    emit(GetAvailableDoctorsLoadingState(),);
    // showLoadingDialog(context, dismissible: false);
    _homeRepo.getAvailableDoctors().then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          error = 'لا يوجد اتصال بالانترنت';
          failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا', context);
        } else if (l is WrongDataFailure) {
          error = l.message.toString();

          failSnackBar(l.message.toString(), 'من فضلك ادخل بيانات صحيحة', context);
        } else if (l is ServerFailure) {
          error = 'هناك مشكلة في السيرفر ';

          failSnackBar(
              'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء', context);
        }
        emit(GetAvailableDoctorsErrorState());
      }, (r) {
        doctorModel = r;
        emit(GetAvailableDoctorsSuccessState(),);
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }

}