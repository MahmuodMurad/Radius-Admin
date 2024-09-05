import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/subscribers_model.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';
import 'package:flutter/scheduler.dart';

class AddBalanceScreen extends StatefulWidget {
  const AddBalanceScreen({super.key, required this.subscriber});
  final SubscribersModel subscriber;

  @override
  State<AddBalanceScreen> createState() => _AddBalanceScreenState();
}

class _AddBalanceScreenState extends State<AddBalanceScreen> {
  TextEditingController balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        centerTitle: true,
        title: Text(
          "اضافة رصيد",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
        ),
      ),
      body: BlocListener<SubscribersCubit, SubscribersState>(
        listener: (context, state) {
          if (state is AddBalanceSuccess) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "تم اضافه مبلغ ${balanceController.text} ل ${widget.subscriber.username} بنجاح"),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }

          if (state is AddBalanceFailure) {
            print(state.error);
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("فشل في اضافة الرصيد: ${state.error}"),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
        },
        child: BlocBuilder<SubscribersCubit, SubscribersState>(
          builder: (context, state) {
            SubscribersCubit subscribersCubit =
            BlocProvider.of<SubscribersCubit>(context);

            return state is AddBalanceLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.0.sp, vertical: 8.0.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.sp),
                      color: AppColors.itemBackground,
                      border: const Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0.sp, vertical: 8.0.sp),
                      child: TextField(
                        controller: balanceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "رقم الرصيد",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(width: 8.w),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                  ),
                  onPressed: () {
                    if (balanceController.text.isNotEmpty) {
                      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx${widget.subscriber.username}");
                      subscribersCubit.addBalance(
                        userName: widget.subscriber.username!,
                        context: context,
                        amount: balanceController.text,
                      );
                      balanceController.clear();
                    }
                  },
                  child: Text(
                    'اشحن',
                    style: TextStyle(
                        color: AppColors.primaryText, fontSize: 16.sp),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
