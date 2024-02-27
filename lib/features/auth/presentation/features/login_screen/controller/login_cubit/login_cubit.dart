import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../../../../../../utils/di/injection.dart';
import '../../../../../../../utils/errors/failures.dart';
import '../../../../../../../utils/helper/hive_helper.dart';
import '../../../../../../../utils/network/connection/network_info.dart';
import '../../../../../../../utils/resources/snackbar_widget.dart';
import '../../../../../../splash_screen/presentation/view/splash_screen.dart';
import '../../../../../data/data_sources/auth_data_source.dart';
import '../../../../../data/repos/auth_repo.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final AuthRepo _authRepo = AuthRepo(
      networkInfo: instance<NetworkInfoImp>(),
      authDataSource: AuthDataSource());

  void login({
    required String userName,
    required String password,
    required BuildContext context,
  }) {
    Map<String, dynamic> body = {
      "P_ACCOUNT_NAME": userName,
      "P_ACCOUNT_PASSWORD": password
    };

    emit(LoginLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _authRepo.login(headers: {}, body: body).then((value) {
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
        emit(LoginErrorState(error.toString()));
      }, (r) async {
        setDeviceToken(r, context);
      });
    });
  }

  setDeviceToken(r, context) async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(r.data!.token!);
    _authRepo.sendFCMToken(headers: {
      'Authorization': r.data!.token!,
    }, body: {
      'NOTIFICATION': token,
    }).then((value) {
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
        emit(LoginErrorState(error.toString()));
      }, (x) async {
        HiveHelper.setUserData(r);
        HiveHelper.setToken(r.data!.token!);
        emit(LoginSuccessState(r));
        Navigator.of(context).pushNamedAndRemoveUntil(
            SplashScreen.routeName, (Route<dynamic> route) => false);
      });
    });
  }

  clearFcmToken(context) async {
    emit(ClearFCMTokenLoadingState());
    _authRepo.sendFCMToken(headers: {
      'Authorization': HiveHelper.getToken(),
    }, body: {
      'NOTIFICATION': '',
    }).then((value) {
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
        emit(ClearFCMTokenErrorState());
      }, (x) async {
       /* Navigator.pushNamedAndRemoveUntil(
          context,
          OnBoardingScreen.routeName,
          ModalRoute.withName(OnBoardingScreen.routeName),
        );*/
        HiveHelper.logout();
        emit(ClearFCMTokenSuccessState());
      });
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? IconlyBroken.show : IconlyBroken.hide;

    emit(ChangePasswordVisibilityState());
  }
}
