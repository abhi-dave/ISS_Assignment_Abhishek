import 'package:dio/dio.dart';
import 'package:iss_assignment/core/api_end_points.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient {
  static final HttpClient _singleton = HttpClient._internal();

  factory HttpClient() {
    return _singleton;
  }

  HttpClient._internal();

  late Dio _client;
  Map<String, dynamic> headers = {};

  void initialize() {
    _client = Dio()..options = BaseOptions(baseUrl: APIEndPoints.baseURL);
    _client.interceptors
        .add(PrettyDioLogger(requestBody: true, responseBody: true));
  }

  Future<dynamic> get(String url) async {
    dynamic responseJson;
    try {
      final response = await _client.get(url);
      responseJson = response.data;
    } on DioException catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {body}) async {
    dynamic responseJson;
    try {
      final response =
          await _client.post<Map<String, dynamic>>(url, data: body);
      responseJson = response.data;
    } on DioException catch (e) {
      print(e);
    }
    return responseJson;
  }
}
