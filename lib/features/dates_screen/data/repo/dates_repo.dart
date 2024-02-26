import 'package:dartz/dartz.dart';
import 'package:hisksa/features/dates_screen/data/data_source/dates_data_source.dart';
import 'package:hisksa/features/dates_screen/data/model/dates_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class DatesRepo {
  NetworkInfo networkInfo;
  DatesDataSource datesDataSource;

  DatesRepo({required this.networkInfo, required this.datesDataSource});

  Future<Either<Failure, DatesModel>> getDates(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        DatesModel result =
            await datesDataSource.getDoctorsDates(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(
          WrongDataFailure(
            message: message.message,
          ),
        );
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
