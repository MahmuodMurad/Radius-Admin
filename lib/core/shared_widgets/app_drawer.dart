import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/core/shared_widgets/notif.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/core/utils/app_constraints.dart';
import 'package:redius_admin/features/auth/presentation/view/login_screen.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';
import 'package:redius_admin/features/subscribers/ui/add_new_subscriber.dart';
import 'package:redius_admin/features/subscribers/ui/all_subscribers_view.dart';
import 'package:redius_admin/features/subscribers/ui/broadband_subscribers.dart';
import 'package:redius_admin/features/subscribers/ui/home/view/home_view.dart';
import 'package:redius_admin/features/subscribers/ui/hotspot_subscribers.dart';
import 'package:redius_admin/features/subscribers/ui/offers/offers_view.dart';
import 'package:redius_admin/features/subscribers/ui/reports/reports_view.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/vouchers_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworksCubit, NetworksState>(
      builder: (context, state) {
        NetworksCubit cubit = BlocProvider.of<NetworksCubit>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              children: [
                 Text(
                  'مرحبا ${cubit.networkUsaing.networkName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),


              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home,color: AppColors.iconColor,),
            title: const Text('الرئيسية',style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt_outlined,color: AppColors.iconColor,),
            title: const Text('كل المشتركيين',style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AllSubscribersView()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.wifi,color: AppColors.iconColor,),
            title: const Text("مشتركين الهوتسبوت",style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HotSpotSubscribersView()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.broadcast_on_home_outlined,color: AppColors.iconColor,),
            title: const Text("مشتركين البرودباند",style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BroadbandSubscribersView()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt_outlined,color: AppColors.iconColor,),
            title: const Text('اضافه مشترك',style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              // Handle navigation or action here
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewSubscriber()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart,color: AppColors.iconColor,),
            title: const Text('التقارير',style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              // Handle navigation or action here
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsView()));
            },
          ),ListTile(
            leading: const Icon(Icons.local_offer_outlined,color: AppColors.iconColor,),
            title: const Text('العروض',style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              // Handle navigation or action here
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ServicesListScreen()));
            },
          ), ListTile(
            leading: const Icon(Icons.credit_card,color: AppColors.iconColor,),
            title: const Text('الكروت',style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              // Handle navigation or action here
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  SeriesVouchersScreen()));
            },
          ),ListTile(
            leading: const Icon(Icons.notification_add,color: AppColors.iconColor,),
            title: const Text( "ارسال اشعارات",style: TextStyle(color: AppColors.primaryText,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
              // Handle navigation or action here
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AdminHomeScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout,color: AppColors.error,),
            title: const Text('تسجيل الخروج',style: TextStyle(color: AppColors.error,fontSize: 18,fontWeight: FontWeight.bold) ,),
            onTap: () {
       LocalDatabase.clearAllSecuredData();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          // Add more list tiles here as needed
        ],
      ),
    );
  },
);
  }
}
