import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

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
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Settings",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Nick",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Image.asset(
                            AppImages.demoAvatar,
                            height: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                ],
              )
            ],
          ),
        ),
      ),
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40.w,
            vertical: 32.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorLight.withOpacity(.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Center(
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          TextSpan(children: [
                            const TextSpan(
                              text: "Notifications: ",
                            ),
                            TextSpan(
                                text: "On",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppColors.yellow,
                                  fontWeight: FontWeight.w600,
                                )),
                            const TextSpan(
                              text: "/",
                            ),
                            const TextSpan(
                              text: "Off",
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Expanded(
                    child: BasicButton(
                      buttonText: "Privacy & Security policy",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColorLight.withOpacity(.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Center(
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          TextSpan(children: [
                            const TextSpan(
                              text: "Profile: ",
                            ),
                            TextSpan(
                                text: "Public",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: AppColors.yellow,
                                  fontWeight: FontWeight.w600,
                                )),
                            const TextSpan(
                              text: "/",
                            ),
                            const TextSpan(
                              text: "Private",
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Expanded(
                    child: BasicButton(
                      buttonText: "FAQ",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: BasicButton(
                      buttonText: "Payment method",
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.paymentMethodScreen,);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Expanded(
                    child: BasicButton(
                      buttonText: "Logout",
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.loginScreen,
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
