



import '../../../../../data/model/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates
{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates
{
  final String error;

  LoginErrorState(this.error);
}

class ClearFCMTokenLoadingState extends LoginStates {}
class ClearFCMTokenSuccessState extends LoginStates {}
class ClearFCMTokenErrorState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}