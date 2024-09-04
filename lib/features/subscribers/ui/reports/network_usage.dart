import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';

class NetworkDataCard extends StatelessWidget {
  final String networkName = "شبكه تجريبي";
  final String hotspotSum = "54.83 KB";
  final String probandSum = "0 B";
  final String monthSum = "54.83 KB";
  final String dailySum = "54.83 KB";
  final String allSum = "54.83 KB";

  const NetworkDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworksCubit, NetworksState>(
  builder: (context, state) {
    NetworksCubit cubit = BlocProvider.of<NetworksCubit>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: AppColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          "تقارير الشبكة",
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
      ),
      body:state is GetNetworkUsaingLoading? const Center(child: CircularProgressIndicator()): Center(
        child: Padding(
          padding:  EdgeInsets.all(16.0.w),
          child: Card(
            color: AppColors.itemBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0.sp),
            ),
            elevation: 5,
            child: Padding(
              padding:  EdgeInsets.all(20.0.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wifi, size: 32.sp, color: AppColors.iconColor),
                      SizedBox(width: 10.w),
                      Text(
                        cubit.networkUsaing.networkName!,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                      const Spacer(),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.accent,
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Text(
                      //     "Test Network",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 12.w,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildDataRow(Icons.cloud_download, "استهلاك الهوتسبوت", cubit.networkUsaing.hotspotSum!),
                  _buildDataRow(Icons.security, "استهلاك البرودباند	", cubit.networkUsaing.probandSum!),
                  _buildDataRow(Icons.date_range, "الاستهلاك الشهري	", cubit.networkUsaing.monthSum!),
                  _buildDataRow(Icons.today, "الاستهلاك اليومي	", cubit.networkUsaing.dailySum!),
                  _buildDataRow(Icons.storage, "الاستهلاك الكلي	", cubit.networkUsaing.allSum!),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }

  Widget _buildDataRow(IconData icon, String label, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0.w),
      child: Row(
        children: [
          Icon(icon, size: 24.sp, color:AppColors.iconColor),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(fontSize: 16.sp, color: AppColors.primaryText),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }
}