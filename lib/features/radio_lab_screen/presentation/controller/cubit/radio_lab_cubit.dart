import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/clinics_screen/data/data_source/clinics_data_source.dart';
import 'package:hisksa/features/clinics_screen/data/model/clinics_model.dart';
import 'package:hisksa/features/clinics_screen/data/repo/clinics_repo.dart';
import 'package:hisksa/features/radio_lab_screen/data/data_source/data_source.dart';
import 'package:hisksa/features/radio_lab_screen/data/model/radio_model.dart';
import 'package:hisksa/features/radio_lab_screen/data/repo/data_repo.dart';
import 'package:hisksa/utils/helper/hive_helper.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import '../../../data/model/lab_model.dart';
import 'radio_lab_states.dart';

class RadioLabCubit extends Cubit<RadioLabStates> {
  RadioLabCubit() : super(RadioLabInitialStates());

  static RadioLabCubit get(context) => BlocProvider.of(context);

  final RadioLabRepo _radioLabRepo = RadioLabRepo(
    networkInfo: instance<NetworkInfoImp>(),
    radioLabDataSource: RadioLabDataSource(),
  );

  RadioModel? radioModel;

  void getRadio(context) {
    print('ttt');
    emit(GetRadioLoadingState());
    _radioLabRepo.getRadio(
        headers: {
          'Authorization' : HiveHelper.getToken(),
        }
    ).then((value) {
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
        emit(GetRadioErrorState());
      }, (r) {
        radioModel = r;
        emit(GetRadioSuccessState(),);
      });
    });
  }

  LabModel? labModel;

  void getLab(context) {
    print('ttt');
    emit(GetLabLoadingState());
    _radioLabRepo.getLab(
      headers: {
        'Authorization' : HiveHelper.getToken(),
      }
    ).then((value) {
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
        emit(GetLabErrorState());
      }, (r) {
        labModel = r;
        emit(GetLabSuccessState(),);
      });
    });
  }

}
