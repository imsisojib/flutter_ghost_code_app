import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSignup extends StatelessWidget {
  const ScreenSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.onPrimaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "Sign up",
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 70.w,
            vertical: 32.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "First name",
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "Last name",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                AdvanceTextFormFieldWithLabel(
                  hintText: "Email",
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "Confirm password",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                BasicButton(
                  width: 160.w,
                  buttonText: "Join",
                  backgroundColor: AppColors.primaryColorDark.withOpacity(.5),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.signupCompleteScreen,
                      (params) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
