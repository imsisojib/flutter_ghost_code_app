import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetHelper{
  static void showDialogWithDynamicContent({
    required Widget content,
    Color? popupBackgroundColor,
    Color? popupBorderColor,
  }) {
    final theme = Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    showDialog(
      barrierLabel: "ConfirmationDialog",
      //barrierColor: Colors.transparent,
      context: sl<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          surfaceTintColor: const Color(0xff795D5D),
          backgroundColor: popupBackgroundColor ?? const Color(0xff795D5D),
          shadowColor: AppColors.secondaryColorLight.withOpacity(.7),
          elevation: 7,
          //backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          //titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //insetPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.all(16.h),
          content: content,
        );
      },
    );
  }
}