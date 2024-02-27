import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../../utils/di/injection.dart';
import '../../../../../../../utils/errors/failures.dart';
import '../../../../../../../utils/network/connection/network_info.dart';
import '../../../../../../../utils/resources/snackbar_widget.dart';
import '../../../../../data/data_sources/auth_data_source.dart';
import '../../../../../data/model/gender.dart';
import '../../../../../data/repos/auth_repo.dart';

part 'get_countries_state.dart';

class GetCountriesCubit extends Cubit<GetCountriesState> {
  GetCountriesCubit() : super(ContractsInitial());

  static GetCountriesCubit get(context) => BlocProvider.of(context);

  final AuthRepo _authRepo = AuthRepo(
    networkInfo: instance<NetworkInfoImp>(),
    authDataSource: AuthDataSource(),
  );

  List<LookUps>? countries;
  void getLookUps(context, {required String id}) {
    print('here are dates');
    emit(GetCountriesStateLoading());
    // showLoadingDialog(context, dismissible: false);
    _authRepo.getLookUps(
        id: id
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
        emit(GetCountriesStateError(error));
      }, (r) {
        countries = r;

        emit(GetCountriesStateLoaded(r));
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}