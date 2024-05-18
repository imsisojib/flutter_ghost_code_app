import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield_with_label.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenPaymentMethod extends StatelessWidget {
  const ScreenPaymentMethod({super.key});

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
                        "Payment method",
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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_left_sharp,
                          color: AppColors.primaryColorDark,
                          size: 40,
                        ),
                      ),
                      IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Image.asset(
                          AppImages.iconHome,
                          height: 24.h,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_right_sharp,
                          color: AppColors.primaryColorDark,
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
              AdvanceTextFormFieldWithLabel(
                hintText: "Full name on card",
                width: 440,
              ),
              SizedBox(
                height: 16.h,
              ),
              AdvanceTextFormFieldWithLabel(
                hintText: "Card number",
                width: 440,
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: 440.w,
                child: Row(
                  children: [
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "Exp Date",
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "CVV",
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Expanded(
                      child: AdvanceTextFormFieldWithLabel(
                        hintText: "Zip Code",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              BasicButton(
                buttonText: "Add Method",
                width: 210,
                onPressed: () {
                  Fluttertoast.showToast(msg: "On development!");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
