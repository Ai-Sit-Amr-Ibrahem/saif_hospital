import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/dates_screen/data/data_source/dates_data_source.dart';
import 'package:hisksa/features/dates_screen/data/model/dates_model.dart';
import 'package:hisksa/features/dates_screen/data/repo/dates_repo.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import 'dates_states.dart';

class DatesCubit extends Cubit<DatesStates> {
  DatesCubit() : super(DatesInitialStates());

  static DatesCubit get(context) => BlocProvider.of(context);


  final DatesRepo _datesRepo = DatesRepo(
    networkInfo: instance<NetworkInfoImp>(),
    datesDataSource: DatesDataSource(),
  );

  DatesModel? datesModel;

  void getDates(context, String clinicId, String docId) {
    print('here are dates');
    emit(GetDatesLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _datesRepo.getDates(
      body: {
        'DOCTOR_ID': docId,
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
        emit(GetDatesErrorState());
      }, (r) {
        datesModel = r;

        emit(
          GetDatesSuccessState(),
        );
        print(datesModel!.data);
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}
