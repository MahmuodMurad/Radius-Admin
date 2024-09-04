import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';
import 'package:redius_admin/features/subscribers/ui/widgets/subscribers.dart';

class AllSubscribersView extends StatelessWidget {
  const AllSubscribersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribersCubit, SubscribersState>(
      builder: (context, state) {
        SubscribersCubit cubit = BlocProvider.of<SubscribersCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "كل المشتركيين",
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.secondary,
          ),
          body: _buildBody(context, state, cubit),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SubscribersState state, SubscribersCubit cubit) {
    if (state is AllSubscribersLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AllSubscribersFailure) {
      return Center(child: Text('Failed to load subscribers: ${state.error}'));
    } else {
      if(cubit.allSubscribers.isEmpty){
        return const Center(child: Text('لا يوجد مشتركين'));
      }else{
        return state is DeleteSubscribersLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
          itemBuilder: (ctx, index) {
            return MyCustomWidget(
              subscriber: cubit.allSubscribers[index],
ctx:  context,
              resetBalance: () {
                cubit.resetBalance(context: context,userName: cubit.allSubscribers[index].username);
              } ,
              onDelete: () {
                cubit.deleteSubscribers(context: context, userName: cubit.allSubscribers[index].username);
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemCount: cubit.allSubscribers.length,
        );
      }
    }
  }
}
