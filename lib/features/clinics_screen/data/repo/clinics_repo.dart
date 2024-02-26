import 'package:dartz/dartz.dart';
import 'package:hisksa/features/clinics_screen/data/data_source/clinics_data_source.dart';
import 'package:hisksa/features/clinics_screen/data/model/clinics_model.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class ClinicsRepo {
  NetworkInfo networkInfo;
  ClinicsDataSource clinicsDataSource;

  ClinicsRepo({required this.networkInfo, required this.clinicsDataSource});

  Future<Either<Failure, ClinicsModel>> getClinics(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        ClinicsModel result =
        await clinicsDataSource.getClinics(body: body, headers: headers);
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