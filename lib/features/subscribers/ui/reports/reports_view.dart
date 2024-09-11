import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';

import 'package:redius_admin/features/subscribers/ui/home/view/widgets/home_item.dart';
import 'package:redius_admin/features/subscribers/ui/reports/financial_usage.dart';
import 'package:redius_admin/features/subscribers/ui/reports/network_usage.dart';
import 'package:redius_admin/features/subscribers/ui/reports/user_data_usage.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworksCubit, NetworksState>(
      builder: (context, state) {
        NetworksCubit cubit = BlocProvider.of<NetworksCubit>(context);

        return Scaffold(
          backgroundColor: AppColors.secondaryBackground,
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            title: const Text(
              "التقارير",
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 24,
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
          body: state is GetUsersStatusLoading || state is GetNetworkUsaingLoading || state is GetCustomerFinancialStatusLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: () async {
              cubit.getCustomerFinancialStatus();
              cubit.getNetworkUsaing();
              cubit.getUsersStatus();
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
                              Icons.category_outlined,
                              color: AppColors.primaryText,
                              size: context.width * 0.06,
                            ),
                            SizedBox(width: context.width * 0.02),
                            const Text("تقارير المشتركين",
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
                            builder: (context) => const NetworkDataCard(),
                          ),
                        );
                      },
                      child: Container(
                        width: context.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.width * 0.03),
                          color: AppColors.itemBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(context.width * 0.03),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: context.width * 0.06,
                                backgroundColor: AppColors.buttonBackground,
                                child: Icon(
                                  Icons.network_cell,
                                  color: AppColors.primaryText,
                                  size: context.width * 0.06,
                                ),
                              ),
                              SizedBox(height: context.height * 0.01),
                              const Text(
                                  "تقرير استهلاك الشبكة",
                                  style: TextStyle(
                                    color: AppColors.placeholderText,
                                    fontSize: 24,)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  UserCreditList(),
                          ),
                        );
                      },
                      child: HomeItem(
isReport: true,
                          count:cubit.customerFinancialStatus.length,
                          title: "تقرير حالة العملاء المالي",
                          icon: Icons.money),
                    ),
                    SizedBox(height: context.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  const UserDataScreen(),
                          ),
                        );
                      },
                      child: HomeItem(
                        isReport: true,
                          count:cubit.usersStatus.length,
                          title: "تقرير حالة العملاء",
                          icon: Icons.query_stats_outlined),
                    ),
                    SizedBox(height: context.height * 0.02),

                  ],
                ),
              ),
            ),
          ),
          drawer: const AppDrawer(),
        );
      },
    );
  }
}

