import 'package:dartz/dartz.dart';
import 'package:hisksa/features/radio_lab_screen/data/data_source/data_source.dart';
import 'package:hisksa/features/radio_lab_screen/data/model/radio_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../model/lab_model.dart';

class RadioLabRepo {
  NetworkInfo networkInfo;
  RadioLabDataSource radioLabDataSource;

  RadioLabRepo({required this.networkInfo, required this.radioLabDataSource});

  Future<Either<Failure, RadioModel>> getRadio(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        RadioModel result =
        await radioLabDataSource.getRadio(body: body, headers: headers);
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


  Future<Either<Failure, LabModel>> getLab(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        LabModel result =
        await radioLabDataSource.getLab(body: body, headers: headers);
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