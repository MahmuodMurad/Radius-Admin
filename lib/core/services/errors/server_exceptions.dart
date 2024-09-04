import 'package:dio/dio.dart';
import 'package:redius_admin/core/services/errors/error_model.dart';

class ServerExceptions implements Exception {
  final ErrorModel errorModel;

  ServerExceptions(this.errorModel);

  @override
  String toString() => errorModel.error;
}

void handleDioExceptions(DioException e) {
  String errorMessage = 'An error occurred';

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      errorMessage = 'Connection Timeout. Please try again later.';
      break;
    case DioExceptionType.sendTimeout:
      errorMessage = 'Send Timeout. Please try again later.';
      break;
    case DioExceptionType.receiveTimeout:
      errorMessage = 'Receive Timeout. Please try again later.';
      break;
    case DioExceptionType.badCertificate:
      errorMessage = 'Bad Certificate. The connection could not be verified.';
      break;
    case DioExceptionType.cancel:
      errorMessage = 'Request was cancelled. Please try again.';
      break;
    case DioExceptionType.connectionError:
      errorMessage = 'Connection Error. Please check your internet connection.';
      break;
    case DioExceptionType.unknown:
      errorMessage = 'Unknown Error occurred. Please try again later.';
      break;
    case DioExceptionType.badResponse:
    // Detailed error handling for specific HTTP status codes
      final statusCode = e.response?.statusCode;
      if (statusCode != null) {
        switch (statusCode) {
          case 400:
            errorMessage = e.response?.data['error'];
            break;
          case 401:
            errorMessage = 'Unauthorized. Please check your credentials.';
            break;
          case 403:
            errorMessage = 'Forbidden. You do not have permission to access this resource.';
            break;
          case 404:
            errorMessage = 'Not Found. The requested resource could not be found.';
            break;
          case 500:
            errorMessage = 'Internal Server Error. Please try again later.';
            break;
          default:
            errorMessage = 'An error occurred. Status code: $statusCode';
        }
      } else {
        errorMessage = 'An unexpected error occurred with the response.';
      }
      break;
  }

  throw ServerExceptions(ErrorModel(error: errorMessage));
}
