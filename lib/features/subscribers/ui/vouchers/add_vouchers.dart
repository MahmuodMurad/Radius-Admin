import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/shared_widgets/custom_app_button.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/auth/presentation/view/login_screen.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_state.dart';

class CreateCardPage extends StatefulWidget {
  @override
  _CreateCardPageState createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  final TextEditingController _srvNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _srvPriceController = TextEditingController();
  final TextEditingController _srvDaysController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _srvCountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: AppColors.secondaryBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'اضافه كروت شحن',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
        ),
      ),
      body: BlocBuilder<SeriesVouchersCubit, SeriesVouchersState>(

        builder: (context, state) {

        return Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Service Name Field
                SizedBox(height: 16.0.h),
                TextFormField(

                  controller: _srvNameController,
                  decoration: const InputDecoration(
                    fillColor: AppColors.itemBackground,
                    filled: true,

                    labelText: 'مجموعة كروت الشحن',
                    hintText: '2024-0003',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل مجموعة كروت الشحن';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0.h),

                // Note Field
                TextFormField(

                  controller: _noteController,
                  decoration: const InputDecoration(
                    fillColor: AppColors.itemBackground,
                    filled: true,
                    labelText: 'ملاحظات',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل ملاحظاتك';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0.h),

                // Service Price Field
                TextFormField(

                  controller: _srvPriceController,
                  decoration: const InputDecoration(
                    fillColor: AppColors.itemBackground,
                    filled: true,
                    labelText: 'قيمة الكرت',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل قيمة الكرت';
                    }
                    if (double.tryParse(value) == null) {
                      return 'من فضلك ادخل قيمة صحيحة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0.h),

                // Service Days Field
                TextFormField(

                  controller: _srvDaysController,
                  decoration: const InputDecoration(
                    fillColor: AppColors.itemBackground,
                    filled: true,
                    labelText: 'عدد ارقام الكرت',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of days';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number of days';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0.h),

                // Period Field
                TextFormField(

                  controller: _periodController,
                  decoration: const InputDecoration(
                    fillColor: AppColors.itemBackground,
                    filled: true,
                    labelText: 'الفترة',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the period';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0.h),

                // Service Count Field
                TextFormField(

                  controller: _srvCountController,
                  decoration: const InputDecoration(
                    fillColor: AppColors.itemBackground,
                    filled: true,
                    labelText: 'عدد الكروت',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل عدد الكروت';
                    }
                    if (int.tryParse(value) == null) {
                      return 'من فضلك ادخل عدد صحيح';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0.h),

                // Submit Button
                state is SeriesVouchersLoading ? const Center(child: CircularProgressIndicator()) : CustomAppButton(
                  height: 50.h,
                  width: double.infinity,
                  borderRadius: 20.r,
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with creating the voucher
                      context.read<SeriesVouchersCubit>().addVoucher(
                        srvName: _srvNameController.text,
                        note: _noteController.text,
                        srvPrice: double.parse(_srvPriceController.text),
                        srvDays: int.parse(_srvDaysController.text),
                        period: _periodController.text,
                        srvCount: int.parse(_srvCountController.text),
                      ).then(
                          (value){
                            if (state is SeriesVouchersSuccess) {
                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Voucher created successfully!')),
                              );
                              Navigator.pop(context); // Go back after successful submission
                            } else if (state is SeriesVouchersFailure) {
                              // Show error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to create voucher: ${state.error}')),
                              );
                            }
                          }
                      );
                    }
                  },
                  child: Text(
                    'اضافه كرت شحن',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText),
                  ),
                ),
              ],
            ),
          ),
        );}
      ),
    );
  }
}
