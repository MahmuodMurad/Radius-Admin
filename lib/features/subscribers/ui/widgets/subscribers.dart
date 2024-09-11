import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/shared_function.dart';
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
    required this.onDelete, required this.resetBalance, required this.ctx, required this.reseteSubscription,


  });
final BuildContext ctx;
  final DataModel subscriber;
  final VoidCallback onDelete;
  final VoidCallback reseteSubscription;
  final VoidCallback resetBalance;


  @override
  MyCustomWidgetState createState() => MyCustomWidgetState();
}

class MyCustomWidgetState extends State<MyCustomWidget> {
  bool _isExpanded = false;

TextEditingController balanceController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  void _showAddBalancePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  BlocListener<SubscribersCubit, SubscribersState>(
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
                Navigator.of(context).pop();
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
                  :  FutureBuilder<DocumentSnapshot>(
                future: users.doc(widget.subscriber.username).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while the data is being fetched
                    return AlertDialog(
                      title: Text('Loading...'),
                      content: SizedBox(
                        height: 50.0.sp,
                        width: 50.0.sp,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle any errors that occurred during the fetch
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Failed to load data.'),
                    );
                  } else if (snapshot.hasData) {
                    // Data is successfully fetched
                    Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;

                    // Provide a default value if data is null
                    data ??= {
                      "fcmToken": "", // Provide a default FCM token if needed
                      // Add other default values here if necessary
                    };

                    return AlertDialog(
                      title: Text('اضافة رصيد'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 8.0.sp),
                            child: TextField(
                              controller: balanceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "رقم الرصيد",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
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
                                ).then((value) {
                                  sendNotification(
                                    context,
                                    data?["fcmToken"],
                                    "تم اضافه رصيد",
                                    "تم اضافه رصيد ${balanceController.text} ل ${widget.subscriber.username} بنجاح",
                                  );
                                });
                                balanceController.clear();
                              }
                            },
                            child: Text(
                              'اضافة رصيد',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Handle the case where there is no data and no error
                    return AlertDialog(
                      title: Text('No Data'),
                      content: Text('No data available.'),
                    );
                  }
                },
              );


            },
),
);
      },
    );
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
                    radius: 15.0.w,
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subscriber.fullname!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText),
                      ),
                      Text(
                        widget.subscriber.username!,
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20.0.w,
                    backgroundColor: widget.subscriber.onlineStatus! ? Colors.green : Colors.red,
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
                      SizedBox(
                        width: 180.w,
                        child: Text(
                          widget.subscriber.currentPlan??"لايوجد",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.sp, color: AppColors.secondaryText),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      const Icon(Icons.monetization_on_outlined, color: AppColors.accent),
                      SizedBox(width: 8.w),
                      Text(
                        widget.subscriber.balance??'0',
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Remaining Data
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _isExpanded ? null : 0,
                child: Column(
                  children: [
                    buildInfoRow("البيانات المتبقية", widget.subscriber.remainingQouta??'0'),
                    buildInfoRow("الاستهلاك الحالي", widget.subscriber.totalUsed!),
                    buildInfoRow("الباقه", widget.subscriber.totalQouta!),
                    buildInfoRow("تاريخ الانتهاء", widget.subscriber.expireDate!),
                    buildInfoRow("اسم المستخدم", widget.subscriber.username!),
                    buildInfoRow("الخدمة", (widget.subscriber.subscribtionType??"")== "Login-User"?"هوت سبوت":"برودباند"),
                    buildInfoRow("ديون", widget.subscriber.credit!),
                    buildInfoRow("المدير", widget.subscriber.createdBy!),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('هل أنت متأكد؟'),
                                        content: Text('هل أنت متأكد من الغاء الاشتراك؟'),
                                        actions: [
                                          TextButton(
                                            child: Text('لا'),
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text('نعم'),
                                            onPressed: () {
                                              widget.reseteSubscription();
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'الغاء الاشتراك',
                                  style: TextStyle(color: AppColors.primaryText, fontSize: 16.sp),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonBackground,
                                ),
                                onPressed: (){
                                  _showAddBalancePopup(context);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) =>  AddBalanceScreen(
                                  //     subscriber: widget.subscriber,
                                  //   )),
                                  // );
                                },
                                child: Text(  'اشحن الرصيد',
                                    style:  TextStyle(color: AppColors.primaryText,fontSize: 16.sp)),
                              ),



                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonBackground,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('هل أنت متأكد؟'),
                                        content: Text('هل أنت متأكد من تصفير الحساب؟'),
                                        actions: [
                                          TextButton(
                                            child: Text('لا'),
                                            onPressed: () {
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text('نعم'),
                                            onPressed: () {
                                              widget.resetBalance(); // Apply the action
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'تصفير الحساب',
                                  style: TextStyle(color: AppColors.primaryText, fontSize: 16.sp),
                                ),
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
                                          return FutureBuilder<DocumentSnapshot>(
                                            future: users.doc(widget.subscriber.username).get(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                // Show a loading indicator while the data is being fetched
                                                return AlertDialog(
                                                  title: Text('Loading...'),
                                                  content: SizedBox(
                                                    height: 50.h,
                                                    width: 50.w,
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                );
                                              } else if (snapshot.hasError) {
                                                // Handle any errors that occurred during the fetch
                                                return AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text('Failed to load data.'),
                                                );
                                              } else if (snapshot.hasData) {
                                                // Data is successfully fetched
                                                Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;

                                                // Provide a default value if data is null
                                                data ??= {
                                                  "fcmToken": "", // Provide a default FCM token if needed
                                                };

                                                return AlertDialog(
                                                  title: Text(
                                                    'اختر خطة الاشتراك',
                                                    style: TextStyle(
                                                      color: AppColors.primaryText,
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  content: DropdownButtonFormField<String>(
                                                    isExpanded: true,
                                                    items: cubit.offers.map((offer) {
                                                      return DropdownMenuItem<String>(
                                                        value: offer.id.toString(),
                                                        child: Text(
                                                          offer.srvName ?? 'No Name', // Provide a default text if srvName is null
                                                          style: TextStyle(
                                                            color: AppColors.primaryText,
                                                            fontSize: 16.sp,
                                                          ),
                                                        ),
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
                                                        final selectedOffer = cubit.offers.firstWhere(
                                                              (offer) => offer.id.toString() == selectedId,
                                                          orElse: () => cubit.offers.first, // Provide a fallback if selectedId is not found
                                                        );

                                                        subscribersCubit.renewSubscribtion(
                                                          userName: widget.subscriber.username!,
                                                          context: context,
                                                          id: selectedOffer.id.toString(),
                                                        ).then((value) {
                                                          sendNotification(
                                                            context,
                                                            data?["fcmToken"],
                                                            "تم تجديد الاشتراك",
                                                            "تم تجديد الاشتراك بنجاح",
                                                          );

                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      child: const Text('تأكيد'),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                // Handle the case where there is no data and no error
                                                return AlertDialog(
                                                  title: Text('No Data'),
                                                  content: Text('No data available.'),
                                                );
                                              }
                                            },
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
                          SizedBox(height: 8.h),
                          Center(child:  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('هل أنت متأكد؟'),
                                    content: Text('هل أنت متأكد من حذف الحساب؟'),
                                    actions: [
                                      TextButton(
                                        child: Text('لا'),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                      ),
                                      TextButton(
                                        child: Text('نعم'),
                                        onPressed: () {
                                          widget.onDelete(); // Apply the action
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              'حذف الحساب',
                              style: TextStyle(color: AppColors.primaryText, fontSize: 16.sp),
                            ),
                          ),

                             ), SizedBox(width: 8.w),
                        ],
                      ),
                    ),
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
              // if (_isAddingBalance)
              //   TextField(
              //     controller: _balanceController,
              //     decoration: const InputDecoration(
              //       hintText: 'ادخل المبلغ',
              //       hintStyle: TextStyle(color: AppColors.secondaryText),
              //     ),
              //     keyboardType: TextInputType.number,
              //   ),

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
