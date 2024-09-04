import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/shared_widgets/custom_app_button.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/data/models/server_group_model.dart';
import 'package:redius_admin/features/subscribers/data/models/user_group_model.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';

class AddNewSubscriber extends StatefulWidget {
  const AddNewSubscriber({super.key});

  @override
  AddNewSubscriberState createState() => AddNewSubscriberState();
}

class AddNewSubscriberState extends State<AddNewSubscriber> {
  // Controllers for TextFormFields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController accountCodeController = TextEditingController();
  final TextEditingController limitController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Variables for Dropdowns
  int? serviceType;
  var endOfSubscription;
  var endOfAgency;
  var travel;
  var clientGroup;

  // Variables for RadioButtons
   bool allowRecieveNotifications=true;
   bool allowSelfPassChange=true;
   bool allowUserPanel=true;
   bool allowUserSms=true;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscribersCubit, SubscribersState>(
      listener: (context, state) {
        if (state is AddSubscribersSuccess) {
          firstNameController.clear();
          lastNameController.clear();
          usernameController.clear();
          passwordController.clear();
          mobileNumberController.clear();
          accountCodeController.clear();
          limitController.clear();
          notesController.clear();
        }
      },
      builder: (context, state) {
        SubscribersCubit Scubit = BlocProvider.of<SubscribersCubit>(context);
        return Scaffold(
          drawer: const AppDrawer(),
          backgroundColor: AppColors.secondaryBackground,
          appBar: AppBar(

            title: const Text(
              'اضافه مشترك',
              style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            centerTitle: true,
            backgroundColor: AppColors.secondary,
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: ListView(
              children: [
                buildTextField('الاسم الأول', Icons.person,
                    controller: firstNameController),
                buildTextField('العائلة', Icons.people,
                    controller: lastNameController),
                buildTextField('اسم المستخدم', Icons.account_circle,
                    controller: usernameController),
                buildTextField('كلمة المرور', Icons.lock,
                    isPassword: true, controller: passwordController),
                buildTextField('رقم الموبايل', Icons.phone,
                    controller: mobileNumberController),
                buildTextField('كود حماية الحساب', Icons.security,
                    controller: accountCodeController),
                buildDropdownField(
                  'نوع الخدمة',
                  Icons.arrow_drop_down,
                  value: serviceType, // The selected index + 1
                  onChanged: (newValue) {
                    setState(() {
                      serviceType =
                          newValue; // Set the selected index + 1
                      print("serviceType: $serviceType");
                    });
                  },
                  items: ['هوت سبوت', 'برودباند', 'ماك ادرس', 'VPN'],
                ),
                buildTextField('اقصى مديونيه', Icons.lock,
                    controller: limitController),
                buildDropdownField('عند انتهاء الاشترك', Icons.arrow_drop_down,
                    value: endOfSubscription, onChanged: (value) {
                      setState(() {
                        endOfSubscription = value;
                        print("endOfSubscription: $endOfSubscription");
                      });
                    }, items: ['فصل الخدمة عن العميل', 'التحويل الى سرعة الفصل', 'التحويل لصفحة انتهاء الاشتراك']),
                buildDropdownField('عند انتهاء الكوته', Icons.arrow_drop_down,
                    value: endOfAgency, onChanged: (value) {
                      setState(() {
                        endOfAgency = value;
                        print("endOfAgency: $endOfAgency");
                      });
                    }, items: ['فصل الخدمة عن العميل', 'التحويل الى سرعة الفصل', 'التحويل لصفحة انتهاء الكوتة']),
                buildDropdownField2(
                  'السيرفر',
                  Icons.arrow_drop_down,
                  value: travel,
                  onChanged: (value) {
                    setState(() {
                      travel = value;
                      print("travel: $travel");
                    });
                  },
                  serverGroups: Scubit.serverGroups,
                ),
                SizedBox(height: 10.h),
                buildDropdownField3(   'مجموعة العملاء',
                  Icons.arrow_drop_down,
                  value: clientGroup,
                  onChanged: (value) {
                    setState(() {
                      clientGroup = value;
                      print("travel: $clientGroup");
                    });
                  },
                  userGroups: Scubit.userGroups, ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildSwitchTile(
                          title: 'السماح بالمعاملات المالية',
                          value: allowRecieveNotifications,
                          onChanged: (bool newValue) {
                            setState(() {
                              allowRecieveNotifications = newValue;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.w), // Add space between the switches
                      Expanded(
                        child: buildSwitchTile(
                          title: 'السماح بتغير كلمة المرور الخاصة بالعميل',
                          value: allowSelfPassChange,
                          onChanged: (bool newValue) {
                            setState(() {
                              allowSelfPassChange = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h), // Add space between the rows
                  Row(
                    children: [
                      Expanded(
                        child: buildSwitchTile(
                          title: 'السماح بالدخول الى لوحة العملاء',
                          value: allowUserPanel,
                          onChanged: (bool newValue) {
                            setState(() {
                              allowUserPanel = newValue;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 16.w), // Add space between the switches
                      Expanded(
                        child: buildSwitchTile(
                          title: 'ارسال رسائل التحذير',
                          value: allowUserSms,
                          onChanged: (bool newValue) {
                            setState(() {
                              allowUserSms = newValue;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

                buildNotesField('ملاحظات', controller: notesController),
                state is AddSubscribersLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomAppButton(
                  backgroundColor: AppColors.buttonBackground,
                  height: 50.h,
                  width: 300.w,
                  onPressed: () {
                    BlocProvider.of<SubscribersCubit>(context)
                        .addSubscribers(
                      context: context,
                      clientName: firstNameController.text,
                      family: lastNameController.text,
                      userName: usernameController.text,
                      password: passwordController.text,
                      mobile: mobileNumberController.text,
                      pin: accountCodeController.text,
                      srvType: (serviceType??0+1).toString(),
                      //serviceType!,
                      afterExp: endOfSubscription.toString(),
                      //endOfSubscription!
                      afterQoutaEnd: endOfAgency.toString(),
                      //endOfAgency!
                      postCredit: limitController.text,
                      serverId: travel.toString(),
                      //travel!
                      userGroup: clientGroup.toString(),
                      //clientGroup!
                      note: notesController.text,
                      allowRecieveNotifications: allowRecieveNotifications==true?"1":"0",
                      allowSelfPassChange: allowSelfPassChange==true?"1":"0",
                      allowUserPanel: allowUserPanel==true?"1":"0",
                      allowUserSms: allowUserSms==true?"1":"0",
                    );
                  },
                  child: const Text(
                    'حفظ',
                    style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }
  DropdownButtonFormField<String> buildDropdownField3(
      String labelText,
      IconData iconData, {
        required String? value,
        required Function(String?) onChanged,
        required List<UserGroupModel> userGroups,
      }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.primaryText),
        filled: true,
        fillColor: AppColors.itemBackground,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
      ),
      dropdownColor: AppColors.itemBackground,
      iconEnabledColor: AppColors.primaryText,
      style: const TextStyle(color: AppColors.primaryText),
      value: value,
      onChanged: onChanged,
      items: userGroups.map((UserGroupModel userGroup) {
        return DropdownMenuItem<String>(
          value: userGroup.groupId,
          child: Text(userGroup.groupName!),
        );
      }).toList(),
    );
  }
  DropdownButtonFormField<String> buildDropdownField2(
      String labelText,
      IconData iconData, {
        required String? value,
        required Function(String?) onChanged,
        required List<ServerGroupModel> serverGroups,
      }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.primaryText),
        filled: true,
        fillColor: AppColors.itemBackground,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.border),
          borderRadius: BorderRadius.circular(8.0.sp),
        ),
      ),
      dropdownColor: AppColors.itemBackground,
      iconEnabledColor: AppColors.primaryText,
      style: const TextStyle(color: AppColors.primaryText),
      value: value,
      onChanged: onChanged,
      items: serverGroups.map((ServerGroupModel serverGroup) {
        return DropdownMenuItem<String>(
          value: serverGroup.nasId,
          child: Text(serverGroup.location!),
        );
      }).toList(),
    );
  }

  Widget buildTextField(String labelText, IconData icon,
      {bool isPassword = false, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColors.primaryText),
          prefixIcon: Icon(icon, color: AppColors.iconColor),
          filled: true,
          fillColor: AppColors.itemBackground,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
        ),
        style: const TextStyle(color: AppColors.primaryText),
      ),
    );
  }

  Widget buildDropdownField(String labelText,
      IconData icon, {
        required int? value, // The selected index + 1
        required Function(int?) onChanged,
        required List<String> items,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: DropdownButtonFormField<int>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColors.primaryText),
          filled: true,
          fillColor: AppColors.itemBackground,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
        ),
        dropdownColor: AppColors.itemBackground,
        iconEnabledColor: AppColors.primaryText,
        style: const TextStyle(color: AppColors.primaryText),
        items: List.generate(items.length, (index) {
          return DropdownMenuItem<int>(
            value: index , // Index + 1
            child: Text(items[index]),
          );
        }),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildSwitchTile({required String title, required bool value, required Function(bool) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        color: value ? Colors.green.shade100 : Colors.red.shade100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.red.shade200,
          ),
        ],
      ),
    );
  }
  Widget buildNotesField(String labelText,
      {required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColors.primaryText),
          fillColor: AppColors.itemBackground,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.circular(8.0.sp),
          ),
        ),
        style: const TextStyle(color: AppColors.primaryText),
      ),
    );
  }
}
