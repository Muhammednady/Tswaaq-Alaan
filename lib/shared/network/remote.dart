import 'dart:io';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: "https://student.valuxapps.com/api/",
          headers: {},
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> postData({
    required String url,
    String lanuage = "en",
    String? token,
    Map? queryParameters,
    Map? data,
  }) async {
    // dio!.options.copyWith(headers: {"lang": lanuage, "Authorization": token});
    dio!.options.headers = {
      "lang": lanuage,
      "Content-Type": "application/json",
      "Authorization": token
    };

    return await dio!.post(url, data: data);
  }

  static Future<Response> getData(
      {required String url,
      String lanuage = "en",
      String? token,
      Map? queryParameters,
      Map? data}) async {
        dio!.options.headers = {
      "lang": lanuage,
      "Content-Type": "application/json",
      "Authorization": token,
    };

    return await dio!.get(url);
  }


static Future<Response> getCategories(
      {required String url,
      String lanuage = "en",
      String? token,
      Map? queryParameters,
      Map? data}) async {
        dio!.options.headers = {
      "lang": lanuage,
      "Content-Type": "application/json",
      "Authorization": token,
    };

    return await dio!.get(url);
  }
  
  static Future<Response> updateProfile(
      {required String url,
      String lanuage = "en",
      required String? token,
      Map? queryParameters,
      required Map? data}) async {

        dio!.options.headers = {
      "lang": lanuage,
      "Content-Type": "application/json",
      "Authorization": token,
    };

    return await dio!.put(url,data: data);
  }
  

}
