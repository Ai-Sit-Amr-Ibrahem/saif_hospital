import 'package:dartz/dartz.dart';
import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';
import 'package:hisksa/features/home_screen/data/model/available_doctors_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../data_source/home_data_source.dart';

class HomeRepo {
  NetworkInfo networkInfo;
  HomeDataSource homeDataSource;

  HomeRepo({required this.networkInfo, required this.homeDataSource});

  Future<Either<Failure, DoctorModel>> getAvailableDoctors(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        DoctorModel result =
        await homeDataSource.getAvailableDoctors(body: body, headers: headers);
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