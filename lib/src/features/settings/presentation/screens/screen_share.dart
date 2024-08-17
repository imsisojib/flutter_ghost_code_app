import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
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
      appBar: GhostAppBar(
        title: 'Share',
        onBack: (){
          Navigator.pop(context);
        },
        onHome: (){
          Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
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
