import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/app_constant.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/core/services/api/api_consumer.dart';
import 'package:redius_admin/core/services/api/api_interceptors.dart';
import 'package:redius_admin/core/services/api/end_point.dart';
import 'package:redius_admin/core/services/errors/server_exceptions.dart';
import 'package:redius_admin/main.dart';

class DioConsumer extends ApiConsumer {
  DioConsumer() {
    dio.options.baseUrl = EndPoint.baseUrl;
    // dio.options.headers['session_id'] = 'mj23v19n8r02ejjqtbc9qrct8i';

    // dio.interceptors.add(AuthInterceptor());
    // dio.interceptors.add(LogInterceptor(
    //   request: true,
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: true,
    //   responseBody: true,
    //   error: true,
    // ));
  }

  Future<String> getSessionId() async {
    final sessionId =
        await LocalDatabase.getSecuredString(AppConstants.sessionId);
    return sessionId ?? '';
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    print('Request URL: ${dio.options.baseUrl}$path');
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(queryParameters!) : null,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? queryParameters,
    required body,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          contentType: isFormData ? 'multipart/form-data' : 'application/json',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    required body,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          contentType: isFormData ? 'multipart/form-data' : 'application/json',
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
