import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/history_details_screen/data/data_source/history_details_data_source.dart';
import 'package:hisksa/features/history_details_screen/data/model/history_details_model.dart';
import 'package:hisksa/features/history_details_screen/data/repo/history_details_data_source.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import 'history_details_states.dart';

class HistoryDetailsCubit extends Cubit<HistoryDetailsStates> {
  HistoryDetailsCubit() : super(HistoryDetailsInitialStates());

  static HistoryDetailsCubit get(context) => BlocProvider.of(context);

  // List<CategoryModel> categories = [];

  final HistoryDetailsRepo _historyDetailsRepo = HistoryDetailsRepo(
    networkInfo: instance<NetworkInfoImp>(),
    historyDetailsDataSource: HistoryDetailsDataSource(),
  );

  HistoryDetailsModel? historyDetailsModel;

  void getHistoryDetails(context, String historyDetailsID, ) {
    print('ttt');
    emit(GetHistoryDetailsLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _historyDetailsRepo.getHistoryDetails(
      headers: {
        'Authorization' : HiveHelper.getToken(),
        'RECEIPT_HEADER_ID' : historyDetailsID,
      },
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
        emit(GetHistoryDetailsErrorState());
      }, (r) {
        historyDetailsModel = r;
        emit(
          GetHistoryDetailsSuccessState(),
        );
      });
    });
  }
}
