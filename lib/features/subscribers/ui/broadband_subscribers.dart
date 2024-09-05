import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';

import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';
import 'package:redius_admin/features/subscribers/ui/widgets/subscribers.dart';

class BroadbandSubscribersView extends StatelessWidget {
  const BroadbandSubscribersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribersCubit, SubscribersState>(
      builder: (context, state) {
        SubscribersCubit cubit = BlocProvider.of<SubscribersCubit>(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "مشتركين البرود باند",
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.secondary,
          ),
          body: state is BroadbandSubscribersLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.broadbandSubscribers.isEmpty? const Center(child: Text("لا يوجد مشتركين")):ListView.separated(
              itemBuilder: (context, index) {
                return MyCustomWidget(
                  subscriber: cubit.broadbandSubscribers[index],
                  resetBalance: () {
                    cubit.resetBalance(context: context,userName: cubit.broadbandSubscribers[index].username!);
                  } ,
                  ctx: context,
                  onDelete: () {
                    cubit.deleteSubscribers(
                        context: context,
                        userName: cubit.broadbandSubscribers[index].username!);
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: cubit.broadbandSubscribers.length),
        );
      },
    );
  }
}
