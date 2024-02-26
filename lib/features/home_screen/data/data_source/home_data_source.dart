import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hisksa/features/home_screen/data/model/available_doctors_model.dart';

import '../../../../utils/di/injection.dart';
import '../../../../utils/errors/exceptions.dart';
import '../../../../utils/log/log.dart';
import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/dio/network_call.dart';
import '../../../../utils/network/urls/end_points.dart';
import '../../../doctors_screen/data/model/doctor_Model.dart';

class HomeDataSource {
  Future<DoctorModel> getAvailableDoctors(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.doctoravalible,
          params: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log. i(res.toString());
    if (res['status'] == 200) {
      return DoctorModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }
}
