import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/vouchers_deatails.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_state.dart';

class VochersDetatils extends StatefulWidget {
  const VochersDetatils({super.key});

  @override
  _VochersDetatilsState createState() => _VochersDetatilsState();
}

class _VochersDetatilsState extends State<VochersDetatils> {
  TextEditingController searchController = TextEditingController();
  List<VouchersDetails> filteredVouchers = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterVouchers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterVouchers() {
    setState(() {
      final seriesVouchersCubit = context.read<SeriesVouchersCubit>();
      filteredVouchers = seriesVouchersCubit.vouchersDetails.where((voucher) {
        final cardNum = voucher.cardNum.toString();
        final searchText = searchController.text;
        return cardNum.contains(searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'تفاصيل القسيمه',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: BlocBuilder<SeriesVouchersCubit, SeriesVouchersState>(
        builder: (context, state) {
          SeriesVouchersCubit seriesVouchersCubit = context.read<SeriesVouchersCubit>();

          if (state is SeriesAllVouchersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'ابحث عن رقم الكارت',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.primaryText),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredVouchers.isEmpty ? seriesVouchersCubit.vouchersDetails.length : filteredVouchers.length,
                  itemBuilder: (context, index) {
                    final voucher = filteredVouchers.isEmpty
                        ? seriesVouchersCubit.vouchersDetails[index]
                        : filteredVouchers[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      color: AppColors.itemBackground,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
