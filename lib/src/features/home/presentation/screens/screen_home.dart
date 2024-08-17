import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/stroke_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderAccount>().fetchLoggedInUserProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: GhostAppBar(
        title: 'Home',
        onNext: (){
          Navigator.pushNamed(
            context,
            Routes.merchandiseScreen,
          );
        },
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
                        Navigator.pushNamed(
                          context,
                          Routes.merchandiseScreen,
                        );
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
                        Navigator.pushNamed(
                          context,
                          Routes.locationScreen,
                        );
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
                        Navigator.pushNamed(
                          context,
                          Routes.tutorialScreen,
                        );
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
                        Navigator.pushNamed(
                          context,
                          Routes.gameScreenHandler,
                        );
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
                      icon: Image.asset(AppImages.iconShare),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.shareScreen,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: IconButton(
                      icon: Image.asset(AppImages.iconSettings),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.settingsScreen,
                        );
                      },
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
