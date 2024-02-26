import 'package:dartz/dartz.dart';
import 'package:hisksa/features/my_booking_screen/data/data_source/my_booking_data_source.dart';
import 'package:hisksa/features/my_booking_screen/data/model/my_booking_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class MyBookingRepo {
  NetworkInfo networkInfo;
  MyBookingDataSource myBookingDataSource;

  MyBookingRepo({required this.networkInfo, required this.myBookingDataSource});

  Future<Either<Failure, MyBookingModel>> getMyBooking(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        MyBookingModel result =
        await myBookingDataSource.getMyBooking(body: body, headers: headers);
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