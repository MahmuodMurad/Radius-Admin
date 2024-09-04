import 'dart:async';
import 'package:flutter/material.dart';
import 'package:redius_admin/app_constant.dart';
import 'package:redius_admin/core/cache_helper/extensions.dart';
import 'package:redius_admin/core/cache_helper/local_database.dart';
import 'package:redius_admin/features/auth/presentation/view/login_screen.dart';
import 'package:redius_admin/features/subscribers/ui/home/view/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLoggedInUser;

  Future<void> checkIfLoggedInUser() async {
    String? userToken = await LocalDatabase.getSecuredString(AppConstants.sessionId);

    if (!userToken.isNullOrEmpty()) {
      isLoggedInUser = true;
    } else {
      isLoggedInUser = false;
    }
  }

  @override
  void initState() {
    super.initState();

    // Check if user is logged in and navigate accordingly after the splash screen duration
    checkIfLoggedInUser().then((_) {
      Timer(
        const Duration(seconds: 3),
            () {
          if (isLoggedInUser == true) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(image: AssetImage("assets/images/llo.jpg")),
          ),
        ],
      ),
    );
  }
}
