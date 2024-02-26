import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hisksa/features/radio_lab_screen/data/model/radio_model.dart';

import '../../../../utils/di/injection.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/log/log.dart';
import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/dio/network_call.dart';
import '../../../../utils/network/urls/end_points.dart';
import '../model/lab_model.dart';

class RadioLabDataSource {
  Future<RadioModel> getRadio(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.radio,
          params: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    if (res['status'] == 200) {
      return RadioModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }



  Future<LabModel> getLab(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.lab,
          params: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    if (res['status'] == 200) {
      return LabModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }


}