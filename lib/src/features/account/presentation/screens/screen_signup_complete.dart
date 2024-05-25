import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSignupComplete extends StatelessWidget {
  const ScreenSignupComplete({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.onPrimaryColorDark,
        automaticallyImplyLeading: false,
        title: Text(
          "Setup",
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
          child: Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AdvanceTextFormFieldWithLabel(
                    hintText: "Display name",
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AdvanceTextFormFieldWithLabel(
                    hintText: "Age",
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  AdvanceTextFormFieldWithLabel(
                    hintText: "Gender",
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  BasicButton(
                    width: 160.w,
                    buttonText: "Save",
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
              )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Upload photo or choose your avatar",
                      style: theme.textTheme.labelSmall,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CircleAvatar(
                      radius: 40.w,
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                      ),
                      itemCount: 8,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (_, index) {
                        return SizedBox(
                          height: 45.h,
                          width: 45.h,
                          child: Image.asset(AppImages.demoAvatar),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
