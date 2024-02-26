import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/clinics_screen/data/data_source/clinics_data_source.dart';
import 'package:hisksa/features/clinics_screen/data/model/clinics_model.dart';
import 'package:hisksa/features/clinics_screen/data/repo/clinics_repo.dart';
import 'package:hisksa/features/clinics_screen/presentation/controller/cubit/clinics_states.dart';
import 'package:hisksa/utils/helper/hive_helper.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import '../../../data/data_source/history_data_source.dart';
import '../../../data/model/history_model.dart';
import '../../../data/repo/clinics_repo.dart';
import 'history_states.dart';

class HistoryCubit extends Cubit<HistoryStates> {
  HistoryCubit() : super(HistoryInitialStates());

  static HistoryCubit get(context) => BlocProvider.of(context);

  final HistoryRepo _historyRepo = HistoryRepo(
    networkInfo: instance<NetworkInfoImp>(),
    historyDataSource: HistoryDataSource(),
  );

  HistoryModel? historyModel;

  void getHistory(context) {
    print('ttt');
    emit(GetHistoryLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _historyRepo.getHistory(
      headers: {
        'Authorization' : HiveHelper.getToken(),
      }
    ).then((value) {
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
        emit(GetHistoryErrorState());
      }, (r) {
        historyModel = r;
        emit(GetHistorySuccessState(),);
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}
