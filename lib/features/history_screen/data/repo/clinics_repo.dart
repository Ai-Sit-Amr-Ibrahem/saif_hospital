import 'package:dartz/dartz.dart';
import 'package:hisksa/features/clinics_screen/data/data_source/clinics_data_source.dart';
import 'package:hisksa/features/clinics_screen/data/model/clinics_model.dart';
import 'package:hisksa/features/history_screen/data/data_source/history_data_source.dart';
import 'package:hisksa/features/history_screen/data/model/history_model.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class HistoryRepo {
  NetworkInfo networkInfo;
  HistoryDataSource historyDataSource;

  HistoryRepo({
    required this.networkInfo,
    required this.historyDataSource,
  });

  Future<Either<Failure, HistoryModel>> getHistory(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        HistoryModel result =
            await historyDataSource.getHistory(body: body, headers: headers);
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
