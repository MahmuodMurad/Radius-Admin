import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/vouchers_deatails.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_state.dart';

class VochersDetatils extends StatelessWidget {
  const VochersDetatils({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        centerTitle: true ,
        backgroundColor: AppColors.secondary,
        title: Text('تفاصيل القسيمه', style: TextStyle(fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText),),
      ),
      body: BlocBuilder<SeriesVouchersCubit, SeriesVouchersState>(
        builder: (context, state) {
          SeriesVouchersCubit seriesVouchersCubit = context.read<SeriesVouchersCubit>();
          return state is SeriesAllVouchersLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
            itemCount: seriesVouchersCubit.vouchersDetails.length,
            itemBuilder: (context, index) {
              final voucher = seriesVouchersCubit.vouchersDetails[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                color: AppColors.itemBackground,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'رقم الكارت',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الحاله',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            voucher.cardNum.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            voucher.cardStatus == '0' ? 'متاح' : 'غير متاح',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
