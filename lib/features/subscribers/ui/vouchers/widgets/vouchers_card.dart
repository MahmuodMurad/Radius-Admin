import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/series_vouchers_model.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_state.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/vochers_detatils.dart';

class VoucherCard extends StatelessWidget {
  final SeriesVouchersModel voucherData;

  const VoucherCard({super.key, required this.voucherData});

  @override
  Widget build(BuildContext context) {
    bool isActive = voucherData.enableStatus == "1";
    bool isExpired = DateTime.parse(voucherData.expireDate!).isBefore(
        DateTime.now());

    return BlocBuilder<SeriesVouchersCubit, SeriesVouchersState>(
      builder: (context, state) {
        SeriesVouchersCubit seriesVouchersCubit = context.read<SeriesVouchersCubit>();
        return Card(
          margin: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(16.w),
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
                _buildHeader(context, isExpired),
                Divider(color: Colors.white, thickness: 1.h),
                SizedBox(height: 8.h),
                _buildDetailRow(
                  context,
                  label: "العدد الكلي	",
                  value: voucherData.voucherCount.toString(),
                  icon: FontAwesomeIcons.ticket,
                ),
                _buildDetailRow(
                  context,
                  label: "القيمة",
                  value: "${voucherData.cardValue}",
                  icon: FontAwesomeIcons.dollarSign,
                ),
                _buildDetailRow(
                  context,
                  label: "العدد المستخدم	",
                  value: voucherData.totalUsed.toString(),
                  icon: FontAwesomeIcons.chartBar,
                ),
                _buildDetailRow(
                  context,
                  label: "تاريخ الانشاء	",
                  value: voucherData.createOnDate!,
                  icon: FontAwesomeIcons.calendarDay,
                ),
                _buildDetailRow(
                  context,
                  label: "تاريخ الانتهاء	",
                  value: voucherData.expireDate!,
                  icon: FontAwesomeIcons.calendarXmark,
                  isWarning: isExpired,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isExpired) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "مجموعة الكروت: ${voucherData.vouchersSeries}",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isExpired ? Colors.red.shade800 : Colors.green.shade800,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            isExpired ? "منتهي" : "فعال",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    bool isWarning = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: isWarning ? Colors.redAccent : Colors.white,
            size: 18.w,
          ),
          SizedBox(width: 8.w),
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: isWarning ? Colors.redAccent : Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
