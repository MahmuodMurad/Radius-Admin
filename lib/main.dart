import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:redius_admin/bloc_observer.dart';
import 'package:redius_admin/app_constant.dart';
import 'package:redius_admin/core/cache_helper/extensions.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/core/services/api/api_interceptors.dart';
import 'package:redius_admin/features/auth/presentation/view/login_screen.dart';
import 'package:redius_admin/core/utils/app_colors.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_cubit.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_cubit.dart';
import 'package:redius_admin/features/subscribers/ui/home/view/home_view.dart';
import 'package:redius_admin/splash_screen.dart';

bool hasInternet = false;
Dio dio = Dio();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// String gSessionId = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  dio.interceptors.add(AuthInterceptor());
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      saveLocale: true,
      startLocale: const Locale('ar'),
      child: const RediusAdmin(),
    ),
  );
}

class RediusAdmin extends StatefulWidget {
  const RediusAdmin({super.key});

  @override
  State<RediusAdmin> createState() => hrState();
}

class hrState extends State<RediusAdmin> {
  late StreamSubscription<InternetConnectionStatus> subscription;

  @override
  void initState() {
    subscription = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              hasInternet = true;
            });
            break;
          case InternetConnectionStatus.disconnected:
            setState(() {
              hasInternet = false;
            });
            break;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SubscribersCubit()
                  ..getSubscribers()
                  ..getBroadbandSubscribers()
                  ..getHostSubscribers()
                  ..getCustomerFinancialStatus()..getUserGroups()..getServerGroups(),
              ),
              BlocProvider(
                create: (context) => NetworksCubit()
                  ..getCustomerFinancialStatus()
                  ..getNetworkUsaing()
                  ..getUsersStatus(),
              ),
              BlocProvider(
                create: (context) => SeriesVouchersCubit()..getSeriesVouchers(),
              ),BlocProvider(
                create: (context) => OffersCubit()..getOffers(),
              ),
            ],
            child: MaterialApp(
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.secondaryBackground,
              ),
              title: "اشتراكي ادمن",
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: hasInternet
                  ? const SplashScreen()
                  : const Scaffold(
                      body: Center(
                        child: Text(
                          "لا يوجد انترنت الرجاء التاكد من الانترنت و اعاده فتح التطبيق",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
          );
        });
  }
}


