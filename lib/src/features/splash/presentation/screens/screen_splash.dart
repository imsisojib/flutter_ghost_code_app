import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSplash extends StatefulWidget{
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {

  void wait3secAndNavigateToHomeScreen() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.pushNamed(context, Routes.homeScreen);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wait3secAndNavigateToHomeScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(AppImages.appLogo,height: 230.h,width: 300.w,),
        ),
      ),
    );
  }

}