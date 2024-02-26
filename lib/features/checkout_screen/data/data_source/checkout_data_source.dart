import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../utils/di/injection.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/dio/network_call.dart';
import '../../../../utils/network/urls/end_points.dart';

class CheckoutDataSource {

  Future<bool> createAppointment(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;

    print('body $body');
    try {
      response = await instance<NetworkCall>().request(EndPoints.createappointment,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      throw ServerException();
    }
    print('res ${response.data}');
    var res = jsonDecode(response.data);
    if (res['status'] == 200) {
      return true;
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }
}