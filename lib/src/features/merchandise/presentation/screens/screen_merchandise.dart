import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/stroke_button.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenMerchandise extends StatelessWidget {
  const ScreenMerchandise({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.onPrimaryColorDark,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Merchandise",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_left_sharp,
                          color: AppColors.primaryColorDark,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Image.asset(
                          AppImages.iconHome,
                          height: 24.h,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_right_sharp,
                          color: AppColors.primaryColorDark,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Nick",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w,),
                      Image.asset(
                        AppImages.demoAvatar,
                        height: 24,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: Background(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Image.asset(
                  AppImages.appLogo,
                  height: 78.h,
                  width: 100.w,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicButton(
                      width: 160.w,
                      buttonText: "Merchandise",
                      buttonTextStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.primaryColorDark.withOpacity(.6),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Coming soon!");
                      },
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    BasicButton(
                      width: 160.w,
                      buttonText: "Locations",
                      buttonTextStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.primaryColorDark.withOpacity(.6),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Coming soon!");
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BasicButton(
                      width: 160.w,
                      buttonText: "Tutorial",
                      buttonTextStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.primaryColorDark.withOpacity(.6),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Coming soon!");
                      },
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    StrokeButton(
                      height: 36,
                      borderRadius: 20,
                      strokeColor: AppColors.red,
                      strokeWidth: 3,
                      width: 160.w,
                      buttonText: "LOAD GAME",
                      buttonTextStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: AppColors.green.withOpacity(.6),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Coming soon!");
                      },
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 16.h,
              right: 24.w,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: IconButton(
                      icon: Image.asset(AppImages.iconLocation),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: IconButton(
                      icon: Image.asset(AppImages.iconSettings),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
