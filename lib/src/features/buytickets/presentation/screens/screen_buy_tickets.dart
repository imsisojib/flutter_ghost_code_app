import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //context.read<ProviderGameEvents>().generateTickets();
      context.read<ProviderGameEvents>().fetchTickets();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderGameEvents>(builder: (_, providerGameEvents, child) {
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
          child: providerGameEvents.loading == ELoading.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : providerGameEvents.event == null
                  ? const Center(
                      child: Text("No event found!"),
                    )
                  : Padding(
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
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: providerGameEvents.mappedTickets.keys.length,
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                //mainAxisSpacing: 50.h,
                                //childAspectRatio: 5.0,
                                mainAxisExtent: 70.h,
                              ),
                              itemBuilder: (_, index) {

                                List<String> keys = providerGameEvents.mappedTickets.keys.toList();
                                keys.sort((a,b)=> a.compareTo(b));
                                String keySlot = keys[index];
                                List<Ticket> tickets = providerGameEvents.mappedTickets[keySlot]?.toList()??[];
                                try{
                                  tickets.sort((a,b)=> a.serial!.compareTo(b.serial!));
                                }catch(e){
                                  // sorting error
                                }

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "$keySlot:",
                                      style: theme.textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Expanded(
                                      child: GridView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount: tickets.length,
                                        shrinkWrap: true,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 10,
                                          //childAspectRatio: 1.5,
                                          mainAxisExtent: 20.h,
                                        ),
                                        itemBuilder: (_, index) {
                                          return Text(
                                            "${tickets[index].serial}",
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: AppColors.yellow,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          BasicButton(
                            buttonText: "Schedule tour",
                            width: 220.w,
                          ),
                        ],
                      ),
                    ),
        ),
      );
    });
  }
}
