
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../utils/di/injection.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/log/log.dart';
import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/dio/network_call.dart';
import '../../../../utils/network/urls/end_points.dart';
import '../model/search_model.dart';

class SearchDataSource {
  Future<SearchModel> getSearchData(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.searchhome,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    print(response.data);
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    if (res['status'] == 200) {
      return SearchModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }
}