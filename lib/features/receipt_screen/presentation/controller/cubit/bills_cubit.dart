
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/helper/hive_helper.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import '../../../data/data_source/bills_data_source.dart';
import '../../../data/model/bills_model.dart';
import '../../../data/repo/bills_repo.dart';
import 'bills_states.dart';

class BillsCubit extends Cubit<BillsStates> {
  BillsCubit() : super(BillsInitialState());

  static BillsCubit get(context) => BlocProvider.of(context);

  final BillsRepo _billsRepo = BillsRepo(
    networkInfo: instance<NetworkInfoImp>(),
    billsDataSource: BillsDataSource(),
  );

  BillsModel? billsModel;

  void getBills(context) {
    print('ttt');
    emit(BillsLoadingState());
    _billsRepo.getBills(
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
        emit(BillsErrorState());
      }, (r) {
        billsModel = r;
        emit(BillsSuccessState(),);
      });
    });
  }

}