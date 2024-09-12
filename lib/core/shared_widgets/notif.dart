import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/shared_widgets/shared_function.dart';
import 'package:redius_admin/core/utils/app_colors.dart';



class AdminHomeScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false); // Loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: AppColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(
          "ارسال اشعارات",
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "عنوان الاشعار",
                labelStyle: const TextStyle(color: AppColors.primaryText),
                prefixIcon: Icon(Icons.title, color: AppColors.iconColor),
                filled: true,
                fillColor: AppColors.itemBackground,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8.0.sp),
                ),
              ),
              style: const TextStyle(color: AppColors.primaryText),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: "محتوى الاشعار",
                labelStyle: const TextStyle(color: AppColors.primaryText),
                prefixIcon: Icon(Icons.abc, color: AppColors.iconColor),
                filled: true,
                fillColor: AppColors.itemBackground,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(8.0.sp),
                ),
              ),
              style: const TextStyle(color: AppColors.primaryText),
            ),
            SizedBox(height: 20.h),
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, loading, _) {
                return  loading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                )
                    :ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0.sp),
                    ),
                  ),
                  onPressed: () async {
                    // Set loading state to true
                    isLoading.value = true;

                    String title = _titleController.text;
                    String body = _bodyController.text;
                    await sendNotificationToAll(context, title, body).then((value) {
                      _bodyController.clear();
                      _titleController.clear();
                    });

                    // Set loading state to false
                    isLoading.value = false;
                  },
                  child: Text(
                    'ارسال الاشعارات',
                    style: TextStyle(fontSize: 20.sp, color: AppColors.secondaryBackground),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



