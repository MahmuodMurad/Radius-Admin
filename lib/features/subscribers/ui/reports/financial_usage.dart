import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/customer_financial_status_model.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';


class UserCreditList extends StatefulWidget {
  @override
  _UserCreditListState createState() => _UserCreditListState();
}

class _UserCreditListState extends State<UserCreditList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworksCubit, NetworksState>(
      builder: (context, state) {
        NetworksCubit cubit = BlocProvider.of<NetworksCubit>(context);

        if (state is GetCustomerFinancialStatusLoading) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'تقرير حالة العملاء المالي',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              backgroundColor: AppColors.secondary,
            ),
            backgroundColor: AppColors.secondaryBackground,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetCustomerFinancialStatusFailure) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'تقرير حالة العملاء المالي',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              backgroundColor: AppColors.secondary,
            ),
            backgroundColor: AppColors.secondaryBackground,
            body: Center(child: Text('Error: ${state.error}')),
          );
        }


          return Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'تقرير حالة العملاء المالي',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.primaryText),
              ),
              backgroundColor: AppColors.secondary,
            ),
            backgroundColor: AppColors.secondaryBackground,
            body: RefreshIndicator(
              onRefresh: () async {
                cubit.getCustomerFinancialStatus();
              },
              child: ListView.builder(
                itemCount: cubit.customerFinancialStatus.length,
                itemBuilder: (context, index) {
                  return _buildUserCreditCard(cubit.customerFinancialStatus[index], index, cubit);
                },
              ),
            ),
          );



      },
    );
  }

  Widget _buildUserCreditCard(CustomerFinancialStatusModel data, int index, NetworksCubit cubit) {
    bool isExpanded = cubit.isExpandedList[index];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: AppColors.primary, width: 2.w),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  data.fullName!,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _buildDataRow("تاريخ الانتهاء", data.expireDate!),
              _buildDataRow("اخر تفعيل اشتراك", data.chargedTime!),
              _buildDataRow("صافي الرصيد", data.creditStatus.toString()),
              if (isExpanded) ...[
                _buildDataRow("الرصيد عليه", data.userCredit!),
                _buildDataRow("الرصيد له", data.userBalance!),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    children: [
                      Text(
                        "حالة الشحن"
                  ,style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      Container(

                        width:20.w  ,
                        height: 20.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: data.activeRecharge =="1" ? Colors.green : Colors.red,
                        ) ,
                      ),
                    ],
                  ),
                ),
              ],
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    cubit.expandList(index);
                  },
                  child: Text(
                    isExpanded ? "اظهر اقل" : "اظهر التفاصيل",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondaryText,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
