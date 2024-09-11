import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/custom_app_button.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_state.dart';

class AddOffers extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _srvNameController = TextEditingController();
  final TextEditingController _downloadSpeedController = TextEditingController();
  final TextEditingController _uploadSpeedController = TextEditingController();
  final TextEditingController _srvPriceController = TextEditingController();
  final TextEditingController _srvTimeController = TextEditingController();
  final TextEditingController _gbValueController = TextEditingController();
  final TextEditingController _totalQuotaController = TextEditingController();
  final TextEditingController _downloadValueController = TextEditingController();
  final TextEditingController _downSpeedUserController = TextEditingController();
  final TextEditingController _srvPriceExtraController = TextEditingController();
  final TextEditingController _uploadValueController = TextEditingController();

  // New controllers for additional fields
  final TextEditingController _srvPriceExtraGbController = TextEditingController(); // New
  final TextEditingController _srvPriceAgentsController = TextEditingController(); // New
  final TextEditingController _srvNameAgentsController = TextEditingController(); // New
  final TextEditingController _totalQuotaExtraController = TextEditingController(); // New

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        title: Text(
          'اضافه باقه جديد',
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText),
        ),
      ),
      body: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          OffersCubit offersCubit = BlocProvider.of<OffersCubit>(context);
          return Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(
                    label: 'اسم الخدمه والعرض',
                    controller: _srvNameController,
                    hintText: 'ادخل اسم الخدمه والعرض',
                  ),
                  Row(
                    children: [
                      // Your existing TextField
                      Expanded(
                          child:_buildTextField(
                            label: 'سرعة التحميل',
                            controller: _downloadSpeedController,
                            hintText: 'ادخل سرعة التحميل',
                            keyboardType: TextInputType.number,
                          ),
                      ),
                      SizedBox(width: 8.0.w),


                      Row(
                        children: [
                          Text('KB'),
                          Radio<int>(
                            value: 0,
                            groupValue: offersCubit.selecteddownloadSpeedUnit,
                            onChanged: (int? value) {
                              offersCubit.updateDownloadSelectedUnit(value!);
                            },
                          ),
                          Text('MB'),
                          Radio<int>(
                            value: 1,
                            groupValue: offersCubit.selecteddownloadSpeedUnit,
                            onChanged: (int? value) {
                              offersCubit.updateDownloadSelectedUnit(value!);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
              Row(
                children: [
                  // Your existing TextField
                  Expanded(
                      child:_buildTextField(
                        label: 'سرعة الرفع',
                        controller: _uploadSpeedController,
                        hintText: 'ادخل سرعة الرفع',
                        keyboardType: TextInputType.number,
                      )
                  ),
                  SizedBox(width: 8.0.w),


                  Row(
                    children: [
                      Text('KB'),
                      Radio<int>(
                        value: 0,
                        groupValue: offersCubit.selectedUploadSpeedUnit,
                        onChanged: (int? value) {
                          offersCubit.updateUploadSelectedUnit(value!);
                        },
                      ),
                      Text('MB'),
                      Radio<int>(
                        value: 1,
                        groupValue: offersCubit.selectedUploadSpeedUnit,
                        onChanged: (int? value) {
                          offersCubit.updateUploadSelectedUnit(value!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
                  _buildTextField(
                    label: 'سعر العرض',
                    controller: _srvPriceController,
                    hintText: 'ادخل سعر العرض',
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    label: 'الوقت على الانترنت',
                    controller: _srvTimeController,
                    hintText: 'ادخل الوقت على الانترنت',
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    label: 'حجم الجيجا',
                    controller: _gbValueController,
                    hintText: ' MBادخل حجم الجيجا',
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      // Your existing TextField
                      Expanded(
                          child:_buildTextField(
                            label: 'كل الجيجات',
                            controller: _totalQuotaController,
                            hintText: 'ادخل كل الجيجات',
                            keyboardType: TextInputType.number,
                          ),
                      ),
                      SizedBox(width: 8.0.w),


                      Row(
                        children: [
                          Text('MB'),
                          Radio<int>(
                            value: 0,
                            groupValue: offersCubit.selectedGBSpeedUnit,
                            onChanged: (int? value) {
                              offersCubit.updateGBSelectedUnit(value!);
                            },
                          ),
                          Text('GB'),
                          Radio<int>(
                            value: 1,
                            groupValue: offersCubit.selectedGBSpeedUnit,
                            onChanged: (int? value) {
                              offersCubit.updateGBSelectedUnit(value!);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildTextField(
                    label: 'سعر الجيجا الاضافية',
                    controller: _srvPriceExtraController,
                    hintText: 'Enter extra service price',
                    keyboardType: TextInputType.number,
                  ),


                  _buildTextField(
                    label: 'سعر الخدمة للموزعين',
                    controller: _srvPriceAgentsController,
                    hintText: 'Enter service price for agents',
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    label: 'اسم الموزع',
                    isServName: true,
                    controller: _srvNameAgentsController,
                    hintText: 'ادخل اسم الموزع',
                  ),
                  // _buildTextField(
                  //   label: 'كل الجيجات الاضافية',
                  //   controller: _totalQuotaExtraController,
                  //   hintText: 'ادخل كل الجيجات الاضافية',
                  //   keyboardType: TextInputType.number,
                  // ),
                  SizedBox(height: 32.0.h),
                  state is OffersLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomAppButton(
                    height: 50.h,
                    width: double.infinity,
                    borderRadius: 20.r,
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Trigger the add offer function
                        context.read<OffersCubit>().addOffer(
                          context: context,
                          downloadValue: offersCubit.selecteddownloadSpeedUnit.toDouble(),
                          // downSpeedUser: double.parse(_downSpeedUserController.text),
                          srvPriceExtra: double.parse(_srvPriceExtraController.text),
                          uploadValue: offersCubit.selectedUploadSpeedUnit.toDouble(),
                          srvName: _srvNameController.text,
                          downloadSpeed: _downloadSpeedController.text,
                          uploadSpeed: _uploadSpeedController.text,
                          srvPrice: double.parse(_srvPriceController.text),
                          srvTime: int.parse(_srvTimeController.text),
                          gbValue: offersCubit.selectedGBSpeedUnit.toDouble(),
                          totalQuota: int.parse(_totalQuotaController.text),
                          srvPriceExtraGb: double.parse(_srvPriceExtraController.text), // New
                          srvPriceAgents: double.parse(_srvPriceAgentsController.text), // New
                          srvNameAgents: _srvNameAgentsController.text, // New
                        );
                      }
                    },
                    child: Text(
                      'اضف العرض',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    bool isServName = false,
    bool isGbValue = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextFormField(
        controller:  controller,
        decoration: InputDecoration(
          fillColor: AppColors.itemBackground,
          filled: true,
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
         validator: (value) {
           isServName ? null :(value == null || value.isEmpty)? 'Please enter $label' : null;

        },
      ),
    );
  }
}
