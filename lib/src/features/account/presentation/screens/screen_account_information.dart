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

class ScreenAccountInformation extends StatelessWidget {
  const ScreenAccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderAccount>(builder: (_, providerAccount, child) {
      return Scaffold(
        appBar: GhostAppBar(
          title: 'Account Information',
          showProfile: false,
          onBack: () {
            Navigator.pop(context);
          },
          onHome: () {
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
          },
        ),
        body: Background(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight.withOpacity(.5),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 24.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 24.h,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Full name",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.yellow.withOpacity(.6),
                        ),
                      ),
                      Text(
                        "${providerAccount.currentModel?.firstName ?? ''} ${providerAccount.currentModel?.lastName ?? ''}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Email",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.yellow.withOpacity(.6),
                        ),
                      ),
                      Text(
                        providerAccount.currentModel?.email ?? 'N/A',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Address",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.yellow.withOpacity(.6),
                        ),
                      ),
                      Text(
                        providerAccount.currentModel?.address??"N/A",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.yellow.withOpacity(.6),
                        ),
                      ),
                      Text(
                        providerAccount.currentModel?.gender ?? 'N/A',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Phone",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.yellow.withOpacity(.6),
                        ),
                      ),
                      Text(
                        providerAccount.currentModel?.phone ?? 'N/A',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Country",
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.yellow.withOpacity(.6),
                        ),
                      ),
                      Text(
                        providerAccount.currentModel?.country ?? 'N/A',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
