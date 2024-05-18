import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/stroke_button.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenMerchandise extends StatelessWidget {
  const ScreenMerchandise({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Merchandise",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
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
              )
            ],
          ),
        ),
      ),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "T-Shirts",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Hoodies",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Hats/Beanies",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Admission",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  BasicButton(
                    width: 200,
                    buttonText: "Buy Tickets",
                  ),
                ],
              ),
              SizedBox(
                width: 24.w,
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 180.h,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 12,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 8.w,
                        ),
                        itemBuilder: (_, index) {
                          return Container(
                              height: 100.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColorLight.withOpacity(.6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.demoTShirt,
                                      height: 56.h,
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Text(
                                      "\$20",
                                      style: theme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        BasicButton(
                          prefix: Image.asset(AppImages.iconCart,height: 28,),
                          buttonText: "0",
                          width: 80.w,
                          buttonTextStyle: theme.textTheme.bodyMedium,
                        ),
                        SizedBox(width: 16.w,),
                        BasicButton(
                          buttonText: "Checkout",
                          width: 200,
                        ),
                      ],
                    )
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
