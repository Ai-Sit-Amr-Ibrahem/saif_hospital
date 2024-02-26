import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../dio_inter/interceptors.dart';
import '../urls/services_urls.dart';


class DioHelper {
  late Dio _dio;

  DioHelper() {
    createDio();
  }

  Dio get dio => _dio;

  void createDio() {
    _dio = Dio(createNewBaseOptions());
    // _dio.interceptors.add(AuthInterceptor());
    // _dio.interceptors.add(LoggingInterceptor());
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  static BaseOptions createNewBaseOptions(
      {baseUrl = ServicesURLs.developmentEnvironment,
      headers = const {
        'lang' : 'AR',
      }}) {
    return BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 10000,
      responseType: ResponseType.plain,
      headers: headers,
      validateStatus: (status) {
        return true;
      },
    );
  }
}
