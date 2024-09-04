import 'package:dio/dio.dart';
import 'package:redius_admin/core/services/api/api_consumer.dart';
import 'package:redius_admin/core/services/api/dio_consumer.dart';
import 'package:redius_admin/core/services/api/end_point.dart';
import 'package:redius_admin/core/services/errors/error_model.dart';
import 'package:redius_admin/core/services/errors/server_exceptions.dart';
import 'package:redius_admin/features/auth/data/models/login_model.dart';

class LoginRepo {
  final ApiConsumer api = DioConsumer();

  Future<LoginModel> login({required String userName, required String password}) async {
    try {
      final formData = FormData.fromMap({
        'username': userName,
        'password': password,
      });

      final response = await api.post(
        EndPoint.login,
        body: formData,
        isFormData: true,
      );

      return LoginModel.fromJson(response);
    } on DioException catch (dioError) {
      String errorMessage = 'An error occurred';
      if (dioError.response != null) {
        errorMessage = dioError.response?.data['message'] ?? dioError.message;
      }
      throw ServerExceptions(ErrorModel(error: errorMessage));
    } catch (e) {
      throw ServerExceptions(ErrorModel(error: e.toString()));
    }
  }
}
