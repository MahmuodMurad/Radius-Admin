import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/app_constant.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/features/auth/presentation/view/login_screen.dart';
import 'package:redius_admin/main.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sessionId = await getSessionId();
    print('AuthInterceptor Session Id: $sessionId');
    // options.headers['session_id'] = sessionId;
    if (sessionId != '') {
      print('Session ID: $sessionId');
      options.headers['Cookie'] = 'PHPSESSID=$sessionId';
    } else {
      // options.headers['Cookie'] = 'PHPSESSID=$gSessionId';
    }
    return handler.next(options);
  }
}


@override
void onError(DioException err, ErrorInterceptorHandler handler) async {
  if (err.response?.statusCode == 401) {
    await LocalDatabase.clearAllSecuredData();
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  } else {
    handler.next(err);
  }
  Future.value();
}
Future<String> getSessionId() async {
  final sessionId = await LocalDatabase.getSecuredString(AppConstants.sessionId);
  return sessionId ?? '';
}
