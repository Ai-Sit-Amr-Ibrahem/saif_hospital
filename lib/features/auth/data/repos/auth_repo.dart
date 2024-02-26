import 'package:dartz/dartz.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../data_sources/auth_data_source.dart';
import '../model/gender.dart';
import '../model/login_model.dart';

class AuthRepo {
  NetworkInfo networkInfo;
  AuthDataSource authDataSource;

  AuthRepo({required this.networkInfo, required this.authDataSource});

  Future<Either<Failure, LoginModel>> login(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        LoginModel result =
        await authDataSource.login(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }


  Future<Either<Failure, LoginModel>> register(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        LoginModel result =
        await authDataSource.register(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, bool>> sendFCMToken(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        bool result =
        await authDataSource.sendFCMToken(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, bool>> resetPassword(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        bool result =
        await authDataSource.resetPassword(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, String>> chkID(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        String result =
        await authDataSource.checkID(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, List<LookUps>>> getLookUps(
      {required String id}) async {
    if (await networkInfo.isConnected) {
      try {
        List<LookUps> result =
        await authDataSource.getLookUps(id: id);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }

    } else {
      return Left(OffLineFailure());
    }
  }

}


