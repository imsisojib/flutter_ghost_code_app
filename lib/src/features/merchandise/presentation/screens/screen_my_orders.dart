import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_loading.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/background.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/ghost_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/providers/provider_merchandise.dart';
import 'package:flutter_boilerplate_code/src/features/merchandise/presentation/widgets/order_tile.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenMyOrders extends StatefulWidget {
  const ScreenMyOrders({super.key});

  @override
  State<ScreenMyOrders> createState() => _ScreenMyOrdersState();
}

class _ScreenMyOrdersState extends State<ScreenMyOrders> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProviderMerchandise>().fetchMyOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderMerchandise>(builder: (_, providerMerchandise, child) {
      return Scaffold(
        appBar: GhostAppBar(
          title: 'My Orders',
          showProfile: false,
          onBack: () {
            Navigator.pop(context);
          },
          onHome: () {
            Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
          },
        ),
        body: Background(
          child: providerMerchandise.loading == ELoading.fetchingData
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : providerMerchandise.orders.isEmpty
              ? const Center(
            child: Text("No order found!"),
          )
              : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
              vertical: 24.h,
            ),
            shrinkWrap: true,
            itemCount: providerMerchandise.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(
                order: providerMerchandise.orders[index],
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
