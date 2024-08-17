import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
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
      appBar: GhostAppBar(
        title: 'Payment method',
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
