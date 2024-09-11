import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/custom_app_button.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/auth/logic/cubit/login_cubit.dart';
import 'package:redius_admin/features/auth/logic/cubit/login_state.dart';
import 'package:redius_admin/features/subscribers/ui/home/view/home_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return Scaffold(
            backgroundColor: AppColors.primaryBackground,
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        SizedBox(height: 20.h),
                            Center(
                              child: Image.asset('assets/images/llo.jpg', height: 150.h),
                            ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            labelText: 'اسم المستخدم',
                            labelStyle:
                            const TextStyle(color: AppColors.placeholderText),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                              const BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                              const BorderSide(color: AppColors.primary),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك ادخل اسم المستخدم';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'كلمه السر',
                            labelStyle:
                            const TextStyle(color: AppColors.placeholderText),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                              const BorderSide(color: AppColors.border),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                              const BorderSide(color: AppColors.primary),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'من فضلك ادخل كلمه السر';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        state is LoginLoading
                            ? const CircularProgressIndicator()
                            : CustomAppButton(
                          width: double.infinity,
                          borderRadius: 10.r,
                          height: 45.h,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                userName: userNameController.text.trim(),
                                password:
                                passwordController.text.trim(),
                              );
                            }
                          },
                          backgroundColor: AppColors.primary,
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
