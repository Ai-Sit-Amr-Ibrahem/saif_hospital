import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/times_screen/data/data_source/times_data_source.dart';
import 'package:hisksa/features/times_screen/data/model/time_model.dart';
import 'package:hisksa/features/times_screen/data/repo/dates_repo.dart';

import '../../../../../utils/di/injection.dart';
import '../../../../../utils/errors/failures.dart';
import '../../../../../utils/network/connection/network_info.dart';
import '../../../../../utils/resources/snackbar_widget.dart';
import 'time_states.dart';

class TimeCubit extends Cubit<TimeStates> {
  TimeCubit() : super(TimeInitialState());

  static TimeCubit get(context) => BlocProvider.of(context);


  final TimeRepo _datesRepo = TimeRepo(
    networkInfo: instance<NetworkInfoImp>(),
    timeDataSource: TimeDataSource(),
  );

  TimeModel? timeModel;

  void getTime(context, int dateId) {
    print('here are dates');
    emit(TimeLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _datesRepo.getTimes(
      body: {
        'RESOURCES_SCHEDULE_ID': dateId,
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
        emit(TimeErrorState());
      }, (r) {
        timeModel = r;

        emit(
          TimeSuccessfulState(),
        );
        print(timeModel!.data);
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}