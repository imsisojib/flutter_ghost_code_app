import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/data/ticket.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/providers/provider_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/screens/widgets/dialog_purchase_tickets.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        appBar: GhostAppBar(
          title: 'Schedule Tour',
          onBack: (){
            Navigator.pop(context);
          },
          onHome: (){
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
          },
          onNext: (){
            Navigator.pushNamed(
              context,
              Routes.locationScreen,
            );
          },
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
                                    "Y = Yellow",
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: AppColors.yellow,
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
                              // const Text(
                              //   "Sync tour with upto 3 friends",
                              // ),
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
                                mainAxisExtent: 80.h,
                              ),
                              itemBuilder: (_, index) {
                                List<String> keys = providerGameEvents.mappedTickets.keys.toList();
                                keys.sort((a, b) => a.compareTo(b));
                                String keySlot = keys[index];
                                List<Ticket> tickets = providerGameEvents.mappedTickets[keySlot]?.toList() ?? [];
                                try {
                                  tickets.sort((a, b) => a.serial!.compareTo(b.serial!));
                                } catch (e) {
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
                                          mainAxisExtent: 24.h,
                                        ),
                                        itemBuilder: (_, index) {
                                          return InkWell(
                                            onTap: () {
                                              if (tickets[index].purchasedBy == null) {
                                                //means, able to select
                                                providerGameEvents.updateSelectedTicket(tickets[index]);
                                              }
                                            },
                                            child: Text(
                                              "${tickets[index].serial}",
                                              style: theme.textTheme.bodySmall?.copyWith(
                                                color: tickets[index].purchasedBy != null
                                                    ? AppColors.red
                                                    : providerGameEvents.selectedTickets.contains(tickets[index])
                                                        ? AppColors.blue
                                                        : AppColors.yellow,
                                              ),
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
                            onPressed: (){
                              if(providerGameEvents.selectedTickets.isEmpty){
                                Fluttertoast.showToast(msg: "Please select ticket first.");
                                return;
                              }

                              WidgetHelper.showDialogWithDynamicContent(content: DialogPurchaseTickets());

                            },
                          ),
                        ],
                      ),
                    ),
        ),
      );
    });
  }
}
