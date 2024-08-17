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

class ScreenAccountSettings extends StatelessWidget {
  const ScreenAccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: GhostAppBar(
        title: 'Account Settings',
        showProfile: false,
        onBack: (){
          Navigator.pop(context);
        },
        onHome: (){
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
        },
        onNext: (){
          Navigator.pushNamed(
            context,
            Routes.accountInformationScreen,
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
              BasicButton(
                buttonText: "Account Information",
                onPressed: (){
                  Navigator.pushNamed(context, Routes.accountInformationScreen);
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: BasicButton(
                      buttonText: "My Orders",
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  Expanded(
                    child: BasicButton(
                      buttonText: "Purchased Tickets",
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              BasicButton(
                buttonText: "Logout",
                onPressed: () {
                  context.read<ProviderAccount>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
