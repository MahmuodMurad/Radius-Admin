import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/users_status_model.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "تقرير حالة العملاء",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        backgroundColor: AppColors.secondary,
      ),
      body: BlocProvider(
        create: (context) => NetworksCubit(),
        child: BlocBuilder<NetworksCubit, NetworksState>(
          builder: (context, state) {
            NetworksCubit cubit = BlocProvider.of<NetworksCubit>(context);
            if (state is GetUsersStatusLoading|| state is GetNetworkUsaingLoading|| state is GetCustomerFinancialStatusLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetUsersStatusFailure) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return _buildUserList(context, cubit.usersStatus);
            }
          },
        ),
      ),
    );
  }

  Widget _buildUserList(
      BuildContext context, List<UsersStatusModel> usersStatus) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<NetworksCubit>().getUsersStatus();
        },
        child: ListView.builder(
          itemCount: usersStatus.length,
          itemBuilder: (context, index) {
            return _buildUserCard(context, usersStatus[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildUserCard(
      BuildContext context, UsersStatusModel data, int index) {
    final cubit = context.read<NetworksCubit>();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.secondary.withOpacity(0.1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.primary, width: 2.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(data),
            SizedBox(height: 10.h),
            _buildStatusRow("نوع الخدمة	", data.srvtype ?? '----'),
            _buildStatusRow("السرعة الحالية	", data.srvMikrotikSpeed ?? '----'),
            _buildStatusRow("تاريخ الانتهاء	", data.expireDate ?? '----'),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                children: [
                  Text(
                    "حالة الشحن",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: data.activeRecharge == "1"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            _buildExpandableDetails(context, cubit, data, index),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(UsersStatusModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: AppColors.primary,
          child: Text(
            data.fullName![0],
            style: TextStyle(
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          data.fullName ?? '----',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(),
      ],
    );
  }

  Widget _buildStatusRow(String label, String value) {
    String formattedValue;

    // Check if the label is "الايام حتى الانتهاء" and the value is a date-time string
    if (label.contains("الايام حتى الانتهاء") &&
        value.isNotEmpty &&
        value != '----') {
      DateTime chargedTime = DateTime.parse(value);
      DateTime now = DateTime.now();

      // Compare chargedTime with the current date and time
      if (chargedTime.isBefore(now)) {
        formattedValue = "منتهي";
      } else {
        formattedValue = value;
      }
    } else {
      formattedValue = value;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
          ),
          Expanded(
            child: Text(
              formattedValue,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableDetails(BuildContext context, NetworksCubit cubit,
      UsersStatusModel data, int index) {
    return GestureDetector(
      onTap: () {
        cubit.expandList(index);
      },
      child: ExpansionTile(
        title: Text(
          'معلومات اكثر',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        // initiallyExpanded: cubit.isExpandedList[index],
        children: [
          _buildStatusRow("الايام حتى الانتهاء", data.chargedTime ?? '----'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              children: [
                Text(
                  "حالة الكوتة	",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.secondaryText,
                  ),
                ),
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: data.overQouta == "0" ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusRow("اخر اتصال	", data.lastSeen ?? '----'),
          _buildStatusRow("استهلاك الكوتة	", data.qoutaUsed ?? '----'),
        ],
      ),
    );
  }
}
