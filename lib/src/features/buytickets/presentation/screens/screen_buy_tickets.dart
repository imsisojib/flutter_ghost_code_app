import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/providers/provider_game_events.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenBuyTickets extends StatefulWidget {
  const ScreenBuyTickets({super.key});

  @override
  State<ScreenBuyTickets> createState() => _ScreenBuyTicketsState();
}

class _ScreenBuyTicketsState extends State<ScreenBuyTickets> {

  @override
  void initState() {
    context.read<ProviderGameEvents>().generateTickets();
    super.initState();
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
                        "Schedule Tour",
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
            horizontal: 32.w,
            vertical: 8.h,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "R = Occupied",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "G = Available",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.green,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "B = Your choice",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Sync tour with upto 3 friends",
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("8PM:",style: theme.textTheme.bodySmall,),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 30,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (_, index) {
                              return Text(
                                "${index * 2}".padLeft(2, "0"),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.yellow,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("10PM:",style: theme.textTheme.bodySmall,),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 30,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (_, index) {
                              return Text(
                                "${index * 2}".padLeft(2, "0"),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.yellow,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("9PM:",style: theme.textTheme.bodySmall,),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 30,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (_, index) {
                              return Text(
                                "${index * 2}".padLeft(2, "0"),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.yellow,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("11PM:",style: theme.textTheme.bodySmall,),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: 30,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (_, index) {
                              return Text(
                                "${index * 2}".padLeft(2, "0"),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.yellow,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h,),
              BasicButton(buttonText: "Schedule tour",width: 220.w,),
            ],
          ),
        ),
      ),
    );
  }
}
