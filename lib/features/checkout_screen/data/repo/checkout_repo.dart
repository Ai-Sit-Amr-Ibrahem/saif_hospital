import 'package:dartz/dartz.dart';
import 'package:hisksa/features/checkout_screen/data/data_source/checkout_data_source.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class CheckoutRepo {
  NetworkInfo networkInfo;
  CheckoutDataSource checkoutDataSource;

  CheckoutRepo({required this.networkInfo, required this.checkoutDataSource});

  Future<Either<Failure, bool>> createAppointment(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        bool result =
        await checkoutDataSource.createAppointment(body: body, headers: headers);
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