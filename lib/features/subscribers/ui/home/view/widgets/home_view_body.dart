import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';
import 'package:redius_admin/features/subscribers/ui/all_subscribers_view.dart';
import 'package:redius_admin/features/subscribers/ui/broadband_subscribers.dart';
import 'package:redius_admin/features/subscribers/ui/home/view/widgets/home_item.dart';
import 'package:redius_admin/features/subscribers/ui/hotspot_subscribers.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribersCubit, SubscribersState>(
      builder: (context, state) {
        SubscribersCubit Scubit = BlocProvider.of<SubscribersCubit>(context);

        return BlocBuilder<NetworksCubit, NetworksState>(
          builder: (context, state) {
            NetworksCubit cubit = BlocProvider.of<NetworksCubit>(context);
    return state is GetNetworkUsaingLoading || state is BroadbandSubscribersLoading || state is HostSubscribersLoading|| state is AllSubscribersLoading ? const Scaffold(body: Center(child: CircularProgressIndicator()),) : Scaffold(
          backgroundColor: AppColors.secondaryBackground,
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            title:  Text(
                      "مرحبا بك : ${cubit.networkUsaing.networkName}",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                );
              },
            ),
          ),
          body: state is BroadbandSubscribersLoading || state is HostSubscribersLoading || state is AllSubscribersLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: () async {
              Scubit.getHostSubscribers();
              Scubit.getBroadbandSubscribers();
              Scubit.getSubscribers();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(context.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.height * 0.02),
                    Container(
                      width: context.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.width * 0.03),
                        color: AppColors.itemBackground,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(context.width * 0.02),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              color: AppColors.primaryText,
                              size: context.width * 0.06,
                            ),
                            SizedBox(width: context.width * 0.02),
                            const Text("معلومات المشتركين",
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 24,
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllSubscribersView(),
                          ),
                        );
                      },
                      child: HomeItem(
                          count: Scubit.allSubscribers.length,
                          title: "كل المشتركين",
                          icon: Icons.people_alt_outlined),
                    ),
                    SizedBox(height: context.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HotSpotSubscribersView(),
                          ),
                        );
                      },
                      child: HomeItem(
                          count: Scubit.hostSubscribers.length,
                          title: "مشتركين الهوتسبوت",
                          icon: Icons.wifi),
                    ),
                    SizedBox(height: context.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BroadbandSubscribersView(),
                          ),
                        );
                      },
                      child: HomeItem(
                          count: Scubit.broadbandSubscribers.length,
                          title: "مشتركين البرودباند",
                          icon: Icons.broadcast_on_home_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: const AppDrawer(),
        );
  },
);
      },
    );
  }
}
