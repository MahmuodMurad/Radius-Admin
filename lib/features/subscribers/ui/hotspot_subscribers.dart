import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';

import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';
import 'package:redius_admin/features/subscribers/ui/widgets/subscribers.dart';

class HotSpotSubscribersView extends StatelessWidget {
  const HotSpotSubscribersView({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribersCubit, SubscribersState>(
      builder: (context, state) {
        SubscribersCubit cubit = BlocProvider.of<SubscribersCubit>(context);
        return Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(
            title: const Text(
              "مشتركين الهوت سبوت",
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.secondary,
          ),
          body: state is HostSubscribersLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.hostSubscribers.isEmpty? const Center(child: Text("لا يوجد مشتركين")):RefreshIndicator(
                onRefresh: () async {
                  cubit.getHostSubscribers();
                },
                child: ListView.separated(
                itemBuilder: (context, index) {
                  return MyCustomWidget(
                    ctx: context,
                    reseteSubscription: () {
                      cubit.resetSubscription(context: context, userName: cubit.allSubscribers[index].username!);
                    },
                    subscriber: cubit.hostSubscribers[index],
                    resetBalance: () {
                      cubit.resetBalance(context: context,userName: cubit.hostSubscribers[index].username!);
                    } ,
                    onDelete: () {
                      cubit.deleteSubscribers(
                          context: context,
                          userName: cubit.hostSubscribers[index].username!);
                    },
                  );
                }, separatorBuilder: (context, index) =>  SizedBox(
                            height: 10.h,
                          ), itemCount: cubit.hostSubscribers.length),
              ),

        );
      },
    );
  }
}
