import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: GhostAppBar(
        title: 'Settings',
        onBack: (){
          Navigator.pop(context);
        },
        onHome: (){
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
        },
        onNext: (){
          Navigator.pushNamed(
            context,
            Routes.tutorialScreen,
          );
        },
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
                        context.read<ProviderAccount>().logout();
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
