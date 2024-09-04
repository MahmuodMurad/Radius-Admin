import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/subscribers_model.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_state.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({
    super.key,
    required this.subscriber,
    required this.onDelete, required this.resetBalance, required this.ctx,


  });
final BuildContext ctx;
  final SubscribersModel subscriber;
  final VoidCallback onDelete;
  final VoidCallback resetBalance;


  @override
  MyCustomWidgetState createState() => MyCustomWidgetState();
}

class MyCustomWidgetState extends State<MyCustomWidget> {
  bool _isExpanded = false;
  bool _isAddingBalance = false;

  final TextEditingController _balanceController = TextEditingController();

  String _calculateRemainingQuota(String quota, String used) {
    try {
      final numQuota = num.parse(quota.replaceAll(RegExp(r'[^0-9.]'), ''));
      final numUsed = num.parse(used.replaceAll(RegExp(r'[^0-9.]'), ''));
      return (numQuota - numUsed).toString();
    } catch (e) {
      return 'N/A';
    }
  }




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscribersCubit, SubscribersState>(
  builder: (context, state) {
    SubscribersCubit subscribersCubit = BlocProvider.of<SubscribersCubit>(context);
    return  Padding(
      padding: EdgeInsets.all(5.0.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.itemBackground,
          borderRadius: BorderRadius.circular(16.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            children: [
              // Profile Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 30.0.w,
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subscriber.fullname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText),
                      ),
                      Text(
                        //TODO: change this
                        "00:08:B6:AE:17:34",
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20.0.w,
                    backgroundColor: widget.subscriber.onlineStatus ? Colors.green : Colors.red,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.category_outlined, color: AppColors.accent),
                      SizedBox(width: 8.w),
                      Text(
                        widget.subscriber.currentPlan,
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.secondaryText),
                      ),
                      SizedBox(width: 70.w),
                      // const Icon(Icons.monetization_on_outlined, color: AppColors.accent),
                      // SizedBox(width: 8.w),
                      // Text(
                      //   widget.subscriber.credit,
                      //   style: TextStyle(
                      //       fontSize: 16.sp, color: AppColors.secondaryText),
                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Remaining Data
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? null : 0, // Adjust the height based on the state
                child: Column(
                  children: [
                    buildInfoRow("البيانات المتبقية", _calculateRemainingQuota(widget.subscriber.totalQuota, widget.subscriber.totalUsed)),
                    buildInfoRow("الاستهلاك الحالي", widget.subscriber.totalUsed),
                    buildInfoRow("الباقه", widget.subscriber.totalQuota),
                    buildInfoRow("تاريخ الانتهاء", widget.subscriber.expireDate),
                    buildInfoRow("اسم المستخدم", widget.subscriber.username),
                    buildInfoRow("الخدمة", widget.subscriber.subscriptionType),
                    buildInfoRow("ديون", widget.subscriber.credit),
                    buildInfoRow("المدير", widget.subscriber.createdBy),
                  ],
                ),
              ),

              // See More/Less Button
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  textStyle: TextStyle(fontSize: 16.sp),
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'اقل' : 'اظهار المزيد',
                  style:  TextStyle(color: AppColors.accent ,fontSize: 16.sp),
                ),
              ),

              // Action Buttons
              if (_isAddingBalance)
                TextField(
                  controller: _balanceController,
                  decoration: const InputDecoration(
                    hintText: 'ادخل المبلغ',
                    hintStyle: TextStyle(color: AppColors.secondaryText),
                  ),
                  keyboardType: TextInputType.number,
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                      ),
                      onPressed: widget.onDelete,
                      child: Text('حذف الحساب',
                          style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 16.sp)),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBackground,
                      ),
                      onPressed: (){
                        if (_balanceController.text.isNotEmpty) {
                          // final newBalance = double.parse(widget.subscriber.credit) +
                          //     double.parse(_balanceController.text);
                          subscribersCubit.addBalance(userName: widget.subscriber.username, context: widget.ctx, amount: _balanceController.text);
                          _balanceController.clear();
                        } else {
                          setState(() {
                            _isAddingBalance = !_isAddingBalance;
                          });
                        }
                      },
                      child: Text(_isAddingBalance ? 'اشحن' : 'اضافة المبلغ',
                          style:  TextStyle(color: AppColors.primaryText,fontSize: 16.sp)),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBackground,
                      ),
                      onPressed: (){
                        widget.resetBalance();
                      },
                      child:  Text('تصفير الحساب', style: TextStyle(color: AppColors.primaryText,fontSize: 16.sp)),
                    ),
                    SizedBox(width: 8.w),
      BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          if (state is OffersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final cubit = context.read<OffersCubit>();

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonBackground,
            ),
            onPressed: () async {
              final selectedPlan = await showDialog<Map<String, String>>(
                context: context,
                builder: (BuildContext context) {
                  String? selectedId;
                  return AlertDialog(
                    title: Text('اختر خطة الاشتراك',style: TextStyle(color: AppColors.primaryText,fontSize: 16.sp,fontWeight: FontWeight.bold) ,),
                    content: DropdownButtonFormField<String>(
                      isExpanded: true,
                      items: cubit.offers.map((offer) {
                        return DropdownMenuItem<String>(
                          value: offer.id.toString(),
                          child: Text(offer.srvName!, style: TextStyle(color: AppColors.primaryText,fontSize: 16.sp)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedId = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        child: const Text('الغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          final selectedOffer = cubit.offers.firstWhere((offer) => offer.id.toString() == selectedId);
                          subscribersCubit.renewSubscribtion(userName: widget.subscriber.username, context: context, id: selectedOffer.id.toString()).then((value) {
                            Navigator.pop(context);
                          });

                        },
                        child: const Text('تأكيد'),
                      ),
                    ],
                  );
                },
              );

              if (selectedPlan != null) {
                // Use the selected plan's ID and name
                print('Selected Plan ID: ${selectedPlan['id']}, Name: ${selectedPlan['name']}');
                // Implement your logic here for renewing the subscription with selectedPlan['id']
              }
            },
            child: Text(
              'تجديد الاشتراك',
              style: TextStyle(color: AppColors.primaryText, fontSize: 16.sp),
            ),
          );
        },
      ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.all(4.0.sp),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.sp),
          color: AppColors.secondaryBackground,
          border: const Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 8.0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, color: AppColors.primaryText),
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.secondaryText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
