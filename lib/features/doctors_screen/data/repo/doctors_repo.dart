import 'package:dartz/dartz.dart';
import 'package:hisksa/features/auth/data/model/gender.dart';
import 'package:hisksa/features/doctors_screen/data/data_source/doctors_data_source.dart';
import 'package:hisksa/features/doctors_screen/data/model/doctor_Model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class DoctorsRepo {
  NetworkInfo networkInfo;
  DoctorsDataSource doctorsDataSource;

  DoctorsRepo({required this.networkInfo, required this.doctorsDataSource});

  Future<Either<Failure, DoctorModel>> getDoctors(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        DoctorModel result =
        await doctorsDataSource.getDoctors(body: body, headers: headers);
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