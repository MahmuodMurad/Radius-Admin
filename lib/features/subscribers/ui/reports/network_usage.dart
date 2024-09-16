import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';

class NetworkDataCard extends StatefulWidget {
  const NetworkDataCard({super.key});

  @override
  _NetworkDataCardState createState() => _NetworkDataCardState();
}

class _NetworkDataCardState extends State<NetworkDataCard> {
  // To store which items have "Show More" enabled.
  Map<int, bool> showMoreMap = {};

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
            title: Text(
              "تقارير الشبكة",
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
          ),
          body: state is GetNetworkUsaingLoading
              ? const Center(child: CircularProgressIndicator())
              : state is GetNetworkUsaingFailure
              ? Center(child: Text("Error: ${state.error}"))
              : RefreshIndicator(
            onRefresh: () async {
              cubit.getNetworkUsaing();
            },
            child: ListView.builder(
              itemCount: cubit.networkUsaingList.length,
              itemBuilder: (context, index) {
                final networkData = cubit.networkUsaingList[index];
                bool showMore = showMoreMap[index] ?? false;

                return Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Card(
                    color: AppColors.itemBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0.sp),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(20.0.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.wifi,
                                  size: 32.sp,
                                  color: AppColors.iconColor),
                              SizedBox(width: 10.w),
                              Text(
                                networkData.networkName!,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          // Show More Button
                          TextButton(
                            onPressed: () {
                              setState(() {
                                showMoreMap[index] =
                                !(showMoreMap[index] ?? false);
                              });
                            },
                            child: Text(
                              showMore ? "عرض أقل" : "عرض المزيد",
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),

                          // Show detailed data if "Show More" is enabled
                          if (showMore) ...[
                            SizedBox(height: 10.h),
                            _buildDataRow(
                                Icons.cloud_download,
                                "استهلاك الهوتسبوت",
                                networkData.hotspotSum!),
                            _buildDataRow(
                                Icons.security,
                                "استهلاك البرودباند",
                                networkData.probandSum!),
                            _buildDataRow(
                                Icons.date_range,
                                "الاستهلاك الشهري",
                                networkData.monthSum!),
                            _buildDataRow(Icons.today,
                                "الاستهلاك اليومي", networkData.dailySum!),
                            _buildDataRow(
                                Icons.storage,
                                "الاستهلاك الكلي",
                                networkData.allSum!),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Row(
        children: [
          Icon(icon, size: 24.sp, color: AppColors.iconColor),
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
