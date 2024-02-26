import 'dart:convert';
import '../../../../utils/di/injection.dart';
import '../../../../utils/errors/exceptions.dart';
import 'package:dio/dio.dart';
import '../../../../utils/network/dio/enum.dart';
import '../../../../utils/network/dio/network_call.dart';
import '../../../../utils/network/urls/end_points.dart';
import '../model/gender.dart';
import '../model/login_model.dart';

class AuthDataSource {

  Future<LoginModel> login(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.login,
          params: body,
          options: Options(method: Method.post.name, headers: headers));
    } catch (error) {
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    if (res['status'] == 200) {
      return LoginModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }

  Future<LoginModel> register(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;

    print('body $body');
    try {
      response = await instance<NetworkCall>().request(EndPoints.register,
          params: body,
          options: Options(method: Method.post.name, headers: headers));
    } catch (error) {
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    print('res $res');
    if (res['status'] == 200) {
      return LoginModel.fromJson(res);
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }

  Future<bool> sendFCMToken(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;

    print('body $body');
    try {
      response = await instance<NetworkCall>().request(EndPoints.updatenotification,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    print('res $res');
    if (res['status'] == 200 || res['status'] == '200') {
      return true;
    } else {
      throw false;
    }
  }

  Future<String> checkID(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;

    print('body $body');
    try {
      response = await instance<NetworkCall>().request(EndPoints.forgetpassowrd,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {

      throw ServerException();
    }
    var res = jsonDecode(response.data);
    print('res $res');
    if (res['status'] == 200) {
      return res['FILE_NUM'];
    } else {
      return res['message'];
    }
  }

  Future<bool> resetPassword(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;

    print('body $body');
    try {
      response = await instance<NetworkCall>().request(EndPoints.updatepass,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    print('res $res');
    if (res['status'] == 200) {
      return true;
    } else {
      throw WrongDataException(res['message'].toString());
    }
  }

  Future<List<LookUps>> getLookUps({required String id}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.genders,
          queryParameters: {
        "LOOKUP_ID":id
          },
          options: Options(method: Method.get.name));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);

      List<dynamic> data = res['items'];
      List<LookUps> genders =
      data.map((genders) => LookUps.fromJson(genders)).toList();
      return genders;
    }
  }


