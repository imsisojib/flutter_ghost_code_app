import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/providers/provider_game_events.dart';
import 'package:flutter_boilerplate_code/src/features/buytickets/presentation/screens/widgets/ticket_tile.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenPurchasedTickets extends StatefulWidget {
  const ScreenPurchasedTickets({super.key});

  @override
  State<ScreenPurchasedTickets> createState() => _ScreenPurchasedTicketsState();
}

class _ScreenPurchasedTicketsState extends State<ScreenPurchasedTickets> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderGameEvents>().fetchPurchasedTickets();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderGameEvents>(builder: (_, providerGameEvents, child) {
      return Scaffold(
        appBar: GhostAppBar(
          title: 'Purchased Tickets',
          showProfile: false,
          onBack: () {
            Navigator.pop(context);
          },
          onHome: () {
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
          },
        ),
        body: Background(
          child: providerGameEvents.loading == ELoading.fetchingData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : providerGameEvents.purchases.isEmpty
                  ? const Center(
                      child: Text("No purchases found!"),
                    )
                  : ListView.separated(
            physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 24.h,
                      ),
                      shrinkWrap: true,
                      itemCount: providerGameEvents.purchases.length,
                      itemBuilder: (_, index) {
                        return TicketTile(
                          purchasedTickets: providerGameEvents.purchases[index],
                        );
                      },
                      separatorBuilder: (_, index) {
                        return SizedBox(
                          height: 24.h,
                        );
                      },
                    ),
        ),
      );
    });
  }
}
