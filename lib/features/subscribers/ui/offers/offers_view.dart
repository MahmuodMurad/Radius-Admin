import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/shared_widgets/app_drawer.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_state.dart';
import 'package:redius_admin/features/subscribers/ui/offers/add_offers.dart';
import 'package:redius_admin/features/subscribers/ui/offers/offer_item.dart';

class ServicesListScreen extends StatelessWidget {

  ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      drawer: const AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon:  Icon(Icons.add, color: AppColors.primaryText, size: 30.sp),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddOffers()));
            },
          ),
        ],
        backgroundColor: AppColors.secondary,
        centerTitle: true,
        title: Text('قايمه العروض',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold,color: AppColors.primaryText) ,),
      ),
      body: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          OffersCubit cubit = BlocProvider.of<OffersCubit>(context);

          return state is OffersLoading ? const Center(child: CircularProgressIndicator()) : RefreshIndicator(
            onRefresh: () async {
              cubit.getOffers();
            },
            child: ListView.builder(
              itemCount: cubit.offers.length,
              itemBuilder: (context, index) {
                final service = cubit.offers[index];
                return ServiceCard(
                  status: service.enableStatus!,
                  createdOn: service.createdOn!,
                  price: service.srvPrice!,
                  speed: service.srvMikrotikSpeed!,
                  dailyQuota: service.dailyQouta!,
                  totalQuota: service.totalQouta!,
                  duration: service.srvTime!,
                  serviceName: service.srvName!,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
