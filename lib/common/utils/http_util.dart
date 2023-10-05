import 'package:dio/dio.dart';
import 'package:ulearning_app/common/values/constant.dart';

import '../../global.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }
  late Dio dio;

  HttpUtil._internal() {
      BaseOptions options = BaseOptions(
          // baseUrl: "https://ulearning.ksa1.cc/",
          baseUrl: AppConstants.SERVER_API_URL,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: "application/json: charset=utf-8",
        responseType: ResponseType.json,
      );
      dio = Dio(options);

  }

  Future post(
            String path,
            {
              dynamic mydata,
              Map<String, dynamic>? queryParameters, //queryParameters is a json data
              Options? options
            }) async {
          Options requestOptions = options ?? Options();
          // if its requestOptions not have headers return an empty map
          requestOptions.headers = requestOptions.headers ?? {};
          Map<String, dynamic>? authorization = getAuthorizationHeader();
          if (authorization != null) {
            requestOptions.headers!.addAll(authorization);
          }
          var response = await dio.post(
            path,
            data: mydata,
            queryParameters: queryParameters,
            options: requestOptions
          );
  // print("my response data is  ${response.toString()}");
  // print("my status code is  ${response.statusCode.toString()}");
  return response.data;
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

}