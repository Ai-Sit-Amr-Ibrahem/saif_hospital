import 'package:dartz/dartz.dart';
import 'package:hisksa/features/history_details_screen/data/model/history_details_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../data_source/history_details_data_source.dart';

class HistoryDetailsRepo {
  NetworkInfo networkInfo;
  HistoryDetailsDataSource historyDetailsDataSource;

  HistoryDetailsRepo({required this.networkInfo, required this.historyDetailsDataSource});

  Future<Either<Failure, HistoryDetailsModel>> getHistoryDetails(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        HistoryDetailsModel result =
        await historyDetailsDataSource.getHistoryDetails(body: body, headers: headers);
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