import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import '../../../data/data_source/doctors_data_source.dart';
import '../../../data/model/doctor_Model.dart';
import '../../../data/repo/doctors_repo.dart';
import 'doctors_states.dart';

class DoctorsCubit extends Cubit<DoctorsStates> {
  DoctorsCubit() : super(DoctorsInitialStates());

  static DoctorsCubit get(context) => BlocProvider.of(context);

  // List<CategoryModel> categories = [];

  final DoctorsRepo _doctorsRepo = DoctorsRepo(
    networkInfo: instance<NetworkInfoImp>(),
    doctorsDataSource: DoctorsDataSource(),
  );

  DoctorModel? doctorModel;

  void getDoctors(context, int clinicId) {
    print('ttt');
    emit(GetDoctorsLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _doctorsRepo.getDoctors(
      body: {
        'CLIINIC_ID': clinicId,
      },
      headers: {},
    ).then((value) {
      // dismissLoadingDialog(context);
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
        emit(GetDoctorsErrorState());
      }, (r) {
        doctorModel = r;
        emit(
          GetDoctorsSuccessState(),
        );
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}
