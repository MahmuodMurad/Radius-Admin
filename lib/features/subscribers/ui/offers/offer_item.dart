import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String status;
  final String createdOn;
  final String price;
  final String speed;
  final String dailyQuota;
  final String totalQuota;
  final String duration;
  final String serviceName;
  final VoidCallback deleteService;

  ServiceCard({
    required this.status,
    required this.createdOn,
    required this.price,
    required this.speed,
    required this.dailyQuota,
    required this.totalQuota,
    required this.duration,
    required this.serviceName, required this.deleteService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.only(left:16.w, right: 16.w, bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [
              AppColors.primary.withOpacity(0.1),
              AppColors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    deleteService();
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.error,
                    size: 30.sp,
                  ),
                ),
              ],
            ),

            _buildHeader(),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailRow('السرعة', speed),
                _buildDetailRow('الكوتة اليومية', dailyQuota),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailRow('الكوتة الكلية', totalQuota),
                _buildDetailRow('المدة', duration),
              ],
            ),

            _buildDetailRow('السعر', '$price '),

            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 240.0.w,
          child: Text(
            serviceName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20.0.sp,
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 10.0.w),
          decoration: BoxDecoration(
            color: status == '0' ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Text(
            status == '0' ? 'مفعل' : 'معطل',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0.h),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Adjust to take only the required space
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            fit: FlexFit.loose, // Ensure the row can shrink if necessary
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'تاريخ الإضافة: $createdOn',
          style: TextStyle(
            fontSize: 14.0.sp,
            color: Colors.white,
          ),
        ),
        const Icon(Icons.date_range, color: Colors.white),
      ],
    );
  }
}
