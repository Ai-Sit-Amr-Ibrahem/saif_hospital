import 'package:dartz/dartz.dart';
import 'package:hisksa/features/search_screen/data/data_source/search_data_source.dart';
import 'package:hisksa/features/search_screen/data/model/search_model.dart';

import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/errors/failures.dart';
import '../../../../utils/network/connection/network_info.dart';

class SearchRepo {
  NetworkInfo networkInfo;
  SearchDataSource searchDataSource;

  SearchRepo({required this.networkInfo, required this.searchDataSource});

  Future<Either<Failure, SearchModel>> getSearch(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        SearchModel result =
        await searchDataSource.getSearchData(body: body, headers: headers);
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