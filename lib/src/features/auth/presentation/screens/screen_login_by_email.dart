import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenLoginByEmail extends StatelessWidget {
  const ScreenLoginByEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.onPrimaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "Login",
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(34),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.appLogo,
                      height: 78.h,
                      width: 100.w,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    AdvanceTextFormFieldWithLabel(
                      hintText: "User name",
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    AdvanceTextFormFieldWithLabel(
                      hintText: "Password",
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    BasicButton(
                      width: 160.w,
                      buttonText: "Login",
                      backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.homeScreen,
                          (params) => false,
                        );
                      },
                    ),
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
