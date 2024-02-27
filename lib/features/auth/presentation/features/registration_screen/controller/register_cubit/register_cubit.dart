import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/splash_screen/presentation/view/splash_screen.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../../../../utils/di/injection.dart';
import '../../../../../../../utils/errors/failures.dart';
import '../../../../../../../utils/helper/hive_helper.dart';
import '../../../../../../../utils/network/connection/network_info.dart';
import '../../../../../../../utils/resources/snackbar_widget.dart';
import '../../../../../data/data_sources/auth_data_source.dart';
import '../../../../../data/repos/auth_repo.dart';
import '../../../login_screen/presentation/view/login_screen.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final AuthRepo _authRepo = AuthRepo(
      networkInfo: instance<NetworkInfoImp>(),
      authDataSource: AuthDataSource());

  void signUp({
    required String name,
    required String userName,
    String? phoneNumber,
    required String password,
    String? nationality,
    required String birthdate,
    String? id,
    String? gender,
    required BuildContext context,
  }) {
    Map<String, dynamic> body = {
      "NATIONALITY": nationality??'',
      "NAMEAR": name,
      "ACCOUNTNAME": userName,
      "PHONE": phoneNumber??'',
      "PASSWORD": password,
      "DATE": "21-06-1997",
      "GENDER": gender??'',
      "IDENTIFYNUM": id??'',
    };

    emit(RegisterLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _authRepo.register(headers: {}, body: body).then((value) {
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
        emit(RegisterErrorState(error.toString()));
      }, (r) {
        HiveHelper.setUserData(r);
        HiveHelper.setToken(r.data!.token!);
        emit(RegisterSuccessState());
        Navigator.of(context).pushNamedAndRemoveUntil(
            SplashScreen.routeName, (Route<dynamic> route) => false);
      });
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}
