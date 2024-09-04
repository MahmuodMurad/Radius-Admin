import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_state.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/add_vouchers.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/vochers_detatils.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/widgets/vouchers_card.dart';

class SeriesVouchersScreen extends StatelessWidget {
  const SeriesVouchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: AppColors.secondaryBackground,
      appBar: AppBar(
        actions: [
          IconButton(
            icon:  Icon(Icons.add, color: AppColors.primaryText, size: 30.w),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateCardPage()));
            },
          ),
        ],
        backgroundColor: AppColors.secondary,
        centerTitle: true,
        title: const Text('قايمه كروت الشحن',style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText) ,),
      ),
      body: BlocBuilder<SeriesVouchersCubit, SeriesVouchersState>(
        builder: (context, state) {
          if (state is SeriesVouchersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SeriesVouchersSuccess||state is SeriesAllVouchersSuccess) {
            final vouchers = context.read<SeriesVouchersCubit>().seriesVouchers;

            if (vouchers.isEmpty) {
              return const Center(child: Text('No Vouchers Available'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SeriesVouchersCubit>().getSeriesVouchers();
              },
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  final voucher = vouchers[index];
                  return GestureDetector(onTap: () {

                      context.read<SeriesVouchersCubit>()
                          .allVoucher(vouchersSeries:  vouchers[index].vouchersSeries!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VochersDetatils(),
                        ),
                      );
                  },child: VoucherCard(voucherData: voucher));
                },
              ),
            );
          } else if (state is SeriesVouchersFailure) {
            return Center(child: Text('Failed to load vouchers: ${state.error}'));
          } else {
            return const Center(child: Text('Please wait...'));
          }
        },
      ),
    );
  }
}
