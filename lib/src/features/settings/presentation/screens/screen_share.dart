import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenShare extends StatelessWidget {
  const ScreenShare({super.key});

  Widget _buildSocialMediaIcon({
    required String assetName,
  }) {
    return InkWell(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 24.w,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            assetName,
          ),
        ),
      ),
    );
  }

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
                        "Share",
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_left_sharp,
                          color: AppColors.primaryColorDark,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        iconSize: 20,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
                        },
                        icon: Image.asset(
                          AppImages.iconHome,
                          height: 24.h,
                        ),
                      ),
                      IconButton(
                        onPressed: () {

                        },
                        icon: Icon(
                          Icons.arrow_right_sharp,
                          color: AppColors.primaryColorDark.withOpacity(.5),
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
              Text(
                "Share your experience with your social friends",
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialMediaIcon(
                    assetName: AppImages.iconTiktok,
                  ),
                  SizedBox(width: 16.w,),
                  _buildSocialMediaIcon(
                    assetName: AppImages.iconYoutube,
                  ),
                  SizedBox(width: 16.w,),
                  _buildSocialMediaIcon(
                    assetName: AppImages.iconInsta,
                  ),
                  SizedBox(width: 16.w,),
                  _buildSocialMediaIcon(
                    assetName: AppImages.iconX,
                  ),
                  SizedBox(width: 16.w,),
                  _buildSocialMediaIcon(
                    assetName: AppImages.iconFb,
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
