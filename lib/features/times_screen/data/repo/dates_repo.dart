import 'package:dartz/dartz.dart';
import 'package:hisksa/features/dates_screen/data/data_source/dates_data_source.dart';
import 'package:hisksa/features/dates_screen/data/model/dates_model.dart';
import 'package:hisksa/features/times_screen/data/data_source/times_data_source.dart';
import 'package:hisksa/features/times_screen/data/model/time_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class TimeRepo {
  NetworkInfo networkInfo;
  TimeDataSource timeDataSource;

  TimeRepo({required this.networkInfo, required this.timeDataSource});

  Future<Either<Failure, TimeModel>> getTimes(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        TimeModel result =
            await timeDataSource.getDoctorsTime(body: body, headers: headers);
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
