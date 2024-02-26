import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/clinics_screen/data/data_source/clinics_data_source.dart';
import 'package:hisksa/features/clinics_screen/data/model/clinics_model.dart';
import 'package:hisksa/features/clinics_screen/data/repo/clinics_repo.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_states.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';

class ClinicsCubit extends Cubit<ClinicsStates> {
  ClinicsCubit() : super(ClinicsInitialStates());

  static ClinicsCubit get(context) => BlocProvider.of(context);

  final ClinicsRepo _clinicsRepo = ClinicsRepo(
    networkInfo: instance<NetworkInfoImp>(),
    clinicsDataSource: ClinicsDataSource(),
  );

  ClinicsModel? clinicsModel;

  void getClinics(context) {
    print('ttt');
    emit(GetClinicsLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _clinicsRepo.getClinics().then((value) {
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
        emit(GetClinicsErrorState());
      }, (r) {
        clinicsModel = r;
        emit(GetClinicsSuccessState(),);
      });
    });
  }
}
