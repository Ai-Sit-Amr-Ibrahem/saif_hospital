import 'package:dartz/dartz.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';
import '../data_source/bills_data_source.dart';
import '../model/bills_model.dart';

class BillsRepo {
  NetworkInfo networkInfo;
  BillsDataSource billsDataSource;

  BillsRepo({required this.networkInfo, required this.billsDataSource});

  Future<Either<Failure, BillsModel>> getBills(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        BillsModel result =
        await billsDataSource.getBills(body: body, headers: headers);
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