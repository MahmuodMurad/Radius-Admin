import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redius_admin/app_constant.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/features/auth/data/repos/login_repo.dart';
import 'package:redius_admin/features/auth/logic/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LoginRepo loginRepo = LoginRepo();

  Future<void> login({required String userName, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await loginRepo.login(
        userName: userName,
        password: password,
      );

      await LocalDatabase.setSecuredString(AppConstants.sessionId, response.sessionId);
      emit(LoginSuccess(message: 'Login successful'));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
