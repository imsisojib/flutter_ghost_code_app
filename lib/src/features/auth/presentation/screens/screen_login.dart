import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(34),
          child: LayoutBuilder(
            builder: (_, constraints){
              return FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogo,
                      height: 78.h,
                      width: 100.w,
                    ),
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BasicButton(
                          width: 160.w,
                          buttonText: "Sign up",
                          backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                          onPressed: (){
                            Navigator.pushNamed(context, Routes.signupByEmailScreen,);
                          },
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        BasicButton(
                          width: 160.w,
                          buttonText: "Login",
                          backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                          onPressed: (){
                            Navigator.pushNamed(context, Routes.loginByEmailScreen,);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 88.w,
                          color: AppColors.gray50,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "Or",
                          style: theme.textTheme.labelMedium,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Container(
                          height: 1,
                          width: 88.w,
                          color: AppColors.gray50,
                        )
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    Center(
                      child: Text(
                        "continue with",
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Image.asset(AppImages.iconApple),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Image.asset(AppImages.iconGoogle),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
