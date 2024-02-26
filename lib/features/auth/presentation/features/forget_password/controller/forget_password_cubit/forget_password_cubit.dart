import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisksa/features/auth/presentation/features/login_screen/presentation/view/login_screen.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../../../../utils/di/injection.dart';
import '../../../../../../../utils/errors/failures.dart';
import '../../../../../../../utils/network/connection/network_info.dart';
import '../../../../../../../utils/resources/constants.dart';
import '../../../../../../../utils/resources/snackbar_widget.dart';
import '../../../../../data/data_sources/auth_data_source.dart';
import '../../../../../data/repos/auth_repo.dart';
import '../../presentation/view/forget_password_screen.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  // ForgetPasswordModel? forgetPasswordModel;

  final AuthRepo _authRepo = AuthRepo(
      networkInfo: instance<NetworkInfoImp>(),
      authDataSource: AuthDataSource());

  void chkID(
      {required String phone,
      required String id,
      required BuildContext context}) {
    Map<String, dynamic> body = {"P_TELEPHONE": phone, "P_NATIONAL_NUMBER": id};
    emit(chkPhoneLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _authRepo.chkID(headers: {}, body: body).then((value) {
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
        emit(chkPhoneErrorState());
      }, (r) {
        Navigator.pushNamed(context, ForgetPasswordScreen.routeName, arguments: r);

        // HiveHelper.setUserData(r);
        // HiveHelper.setToken(r.token!);
        emit(chkPhoneSuccessState());
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }

  void resetPassword(
      {required String fileNum,
      required String password,
      required BuildContext context}) {
    Map<String, dynamic> body = {"P_FILE_NUM": fileNum, "P_ACCOUNT_PASSWORD": password};

    emit(ForgetPasswordLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _authRepo.resetPassword(headers: {}, body: body).then((value) {
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
        emit(ForgetPasswordErrorState());
      }, (r) {

        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'تم تغيير كلمة السر بنجاح',
          onConfirmBtnTap: (){
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LoginScreen.routeName, (Route<dynamic> route) => false);
          }
        );
        // HiveHelper.setUserData(r);
        // HiveHelper.setToken(r.token!);
        emit(ForgetPasswordSuccessState());
        // Navigator.pushNamed(context, SplashScreen.routeName);
      });
    });
  }
}
